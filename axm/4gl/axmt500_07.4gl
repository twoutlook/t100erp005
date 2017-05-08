#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt500_07.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-03 13:55:52), PR版次:0001(2016-11-11 10:29:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: axmt500_07
#+ Description: 維護訂單軟備置子作業
#+ Creator....: 02040(2016-11-03 13:53:44)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="axmt500_07.global" >}
#應用 c02b 樣板自動產生(Version:10)
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
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdr_d        RECORD
       xmdr004 LIKE xmdr_t.xmdr004, 
   xmdr004_desc LIKE type_t.chr500, 
   xmdr005 LIKE xmdr_t.xmdr005, 
   xmdr005_desc LIKE type_t.chr500, 
   xmdr006 LIKE xmdr_t.xmdr006, 
   xmdr003 LIKE xmdr_t.xmdr003, 
   xmdr010 LIKE xmdr_t.xmdr010, 
   xmdr010_desc LIKE type_t.chr500, 
   xmdr008 LIKE xmdr_t.xmdr008, 
   xmdr009 LIKE xmdr_t.xmdr009
       END RECORD
PRIVATE TYPE type_g_xmdr2_d RECORD
       inag004 LIKE type_t.chr10, 
   inag004_desc LIKE type_t.chr500, 
   inag005 LIKE type_t.chr10, 
   inag005_desc LIKE type_t.chr500, 
   inag006 LIKE type_t.chr30, 
   inag003 LIKE type_t.chr30, 
   inad011 LIKE type_t.dat, 
   inag007 LIKE type_t.chr10, 
   inag007_desc LIKE type_t.chr500, 
   inag008 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdrdocno    LIKE xmdr_t.xmdrdocno
DEFINE g_xmdrseq      LIKE xmdr_t.xmdrseq
DEFINE g_xmdrseq1     LIKE xmdr_t.xmdrseq1
DEFINE g_xmdrseq2     LIKE xmdr_t.xmdrseq2
DEFINE g_xmdr001      LIKE xmdr_t.xmdr001
DEFINE g_xmdr002      LIKE xmdr_t.xmdr002
DEFINE g_xmdr007      LIKE xmdr_t.xmdr007
DEFINE g_xmdr008      LIKE xmdr_t.xmdr008

DEFINE g_xmdr        DYNAMIC ARRAY OF RECORD     
       xmdr008          LIKE xmdr_t.xmdr008,
       xmdr009          LIKE xmdr_t.xmdr009,
       xmdr010          LIKE xmdr_t.xmdr010,
       xmdr004          LIKE xmdr_t.xmdr004, 
       xmdr005          LIKE xmdr_t.xmdr005,
       xmdr003          LIKE xmdr_t.xmdr003,
       xmdr006          LIKE xmdr_t.xmdr006,
       xmdr007          LIKE xmdr_t.xmdr007
                     END RECORD
#end add-point
 
DEFINE g_xmdr_d          DYNAMIC ARRAY OF type_g_xmdr_d
DEFINE g_xmdr_d_t        type_g_xmdr_d
DEFINE g_xmdr2_d   DYNAMIC ARRAY OF type_g_xmdr2_d
DEFINE g_xmdr2_d_t type_g_xmdr2_d
 
 
DEFINE g_xmdrdocno_t   LIKE xmdr_t.xmdrdocno    #Key值備份
DEFINE g_xmdrseq_t      LIKE xmdr_t.xmdrseq    #Key值備份
DEFINE g_xmdrseq1_t      LIKE xmdr_t.xmdrseq1    #Key值備份
DEFINE g_xmdrseq2_t      LIKE xmdr_t.xmdrseq2    #Key值備份
DEFINE g_xmdr001_t      LIKE xmdr_t.xmdr001    #Key值備份
DEFINE g_xmdr002_t      LIKE xmdr_t.xmdr002    #Key值備份
DEFINE g_xmdr003_t      LIKE xmdr_t.xmdr003    #Key值備份
DEFINE g_xmdr004_t      LIKE xmdr_t.xmdr004    #Key值備份
DEFINE g_xmdr005_t      LIKE xmdr_t.xmdr005    #Key值備份
DEFINE g_xmdr006_t      LIKE xmdr_t.xmdr006    #Key值備份
DEFINE g_xmdr007_t      LIKE xmdr_t.xmdr007    #Key值備份
 
 
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
 
{<section id="axmt500_07.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt500_07(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xmdrdocno,p_xmdrseq,p_xmdrseq1,p_xmdrseq2,p_xmdr008 
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
   DEFINE p_xmdrdocno    LIKE xmdr_t.xmdrdocno
   DEFINE p_xmdrseq      LIKE xmdr_t.xmdrseq
   DEFINE p_xmdrseq1     LIKE xmdr_t.xmdrseq1
   DEFINE p_xmdrseq2     LIKE xmdr_t.xmdrseq2
   DEFINE p_xmdr008      LIKE xmdr_t.xmdr008
   DEFINE l_inag008      LIKE inag_t.inag008
   DEFINE l_i            LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt500_07 WITH FORM cl_ap_formpath("axm","axmt500_07")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   
   LET g_success = TRUE 
   IF cl_null(p_xmdrdocno) OR cl_null(p_xmdrseq) OR cl_null(p_xmdrseq1) 
     OR cl_null(p_xmdrseq2) OR cl_null(p_xmdr008) THEN
      LET g_success = FALSE
      CLOSE WINDOW w_axmt500_07    #關閉視窗
      RETURN g_success,g_xmdr_d
   END IF   
   
   LET g_xmdrdocno = p_xmdrdocno
   LET g_xmdrseq = p_xmdrseq
   LET g_xmdrseq1 = p_xmdrseq1
   LET g_xmdrseq2 = p_xmdrseq2
   LET g_xmdr008 = p_xmdr008
   
   LET g_xmdr001 = ''
   LET g_xmdr002 = ''
   LET g_xmdr007 = ''
   SELECT xmdd001,xmdd002,xmdd004
     INTO g_xmdr001,g_xmdr002,g_xmdr007
     FROM xmdd_t 
    WHERE xmddent = g_enterprise
      AND xmdddocno = g_xmdrdocno 
      AND xmddseq = g_xmdrseq
      AND xmddseq1 = g_xmdrseq1
      AND xmddseq2 = g_xmdrseq2
      
   LET g_detail_idx = 1
   CALL axmt500_07_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdr_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         BEFORE ROW
           LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
           LET l_ac = g_detail_idx         
           IF cl_null(g_xmdr_d[l_ac].xmdr003) THEN LET g_xmdr_d[l_ac].xmdr003 = ' ' END IF
           IF cl_null(g_xmdr_d[l_ac].xmdr004) THEN LET g_xmdr_d[l_ac].xmdr004 = ' ' END IF
           IF cl_null(g_xmdr_d[l_ac].xmdr005) THEN LET g_xmdr_d[l_ac].xmdr005 = ' ' END IF
           IF cl_null(g_xmdr_d[l_ac].xmdr006) THEN LET g_xmdr_d[l_ac].xmdr006 = ' ' END IF
           LET g_xmdr_d_t.* = g_xmdr_d[l_ac].*          #BACKUP
           CALL axmt500_07_set_entry()
           CALL axmt500_07_set_no_entry()           
          
         AFTER ROW
           IF cl_null(g_xmdr_d[l_ac].xmdr003) THEN LET g_xmdr_d[l_ac].xmdr003 = ' ' END IF
           IF cl_null(g_xmdr_d[l_ac].xmdr004) THEN LET g_xmdr_d[l_ac].xmdr004 = ' ' END IF
           IF cl_null(g_xmdr_d[l_ac].xmdr005) THEN LET g_xmdr_d[l_ac].xmdr005 = ' ' END IF
           IF cl_null(g_xmdr_d[l_ac].xmdr006) THEN LET g_xmdr_d[l_ac].xmdr006 = ' ' END IF
           
           IF NOT cl_null(g_xmdr_d[l_ac].xmdr003) OR NOT cl_null(g_xmdr_d[l_ac].xmdr004) OR
              NOT cl_null(g_xmdr_d[l_ac].xmdr005) OR NOT cl_null(g_xmdr_d[l_ac].xmdr006) THEN
              IF g_xmdr_d[l_ac].xmdr008 <= 0 OR cl_null(g_xmdr_d[l_ac].xmdr008) THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'axm-00803' #已有庫/儲/批/庫存管理特微，備置量不可為空或小於0
                 LET g_errparam.extend = ""
                 LET g_errparam.popup = TRUE
                 CALL cl_err()  
                 NEXT FIELD xmdr008                   
              END IF              
           END IF
           
           #檢查資料是否有重復
           IF g_xmdr_d[l_ac].xmdr008 > 0 THEN
              IF l_ac > 1 THEN
                 FOR l_i = 1 TO g_xmdr_d.getLength()
                     IF l_ac = l_i THEN
                        CONTINUE FOR
                     END IF
                     IF g_xmdr_d[l_ac].xmdr003 = g_xmdr_d[l_i].xmdr003 AND g_xmdr_d[l_ac].xmdr004 = g_xmdr_d[l_i].xmdr004 AND
                        g_xmdr_d[l_ac].xmdr005 = g_xmdr_d[l_i].xmdr005 AND g_xmdr_d[l_ac].xmdr006 = g_xmdr_d[l_i].xmdr006 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'axm-00802' #庫/儲/批/庫存管理特微 資料已重複，請重新確認！
                        LET g_errparam.extend = ""
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_xmdr_d[l_ac].xmdr003 = ' ' 
                        LET g_xmdr_d[l_ac].xmdr004 = ' '
                        LET g_xmdr_d[l_ac].xmdr004_desc = ''
                        LET g_xmdr_d[l_ac].xmdr005 = ' '
                        LET g_xmdr_d[l_ac].xmdr005_desc = ''
                        LET g_xmdr_d[l_ac].xmdr006 = ' '                        
                        LET g_xmdr_d[l_ac].xmdr010 = '' 
                        LET g_xmdr_d[l_ac].xmdr010_desc = ''                        
                        LET g_xmdr_d[l_ac].xmdr008 = ''                     
                        LET g_xmdr_d[l_ac].xmdr009 = ''                       
                        NEXT FIELD xmdr004                       
                     END IF
                 END FOR
              END IF             
              LET g_xmdr_d[l_ac].xmdr010 = g_xmdr007
           END IF
           
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdr004
            
            #add-point:AFTER FIELD xmdr004 name="input.a.page1.xmdr004"
            LET g_xmdr_d[l_ac].xmdr004_desc = ''
            IF NOT cl_null(g_xmdr_d[l_ac].xmdr004) THEN
               IF (g_xmdr_d[l_ac].xmdr004 <> g_xmdr_d_t.xmdr004 OR g_xmdr_d_t.xmdr004 IS NULL) THEN
                  LET l_inag008 = 0
                  CALL axmt500_07_get_inag008(g_xmdr001,g_xmdr002,g_xmdr_d[l_ac].xmdr003,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005,g_xmdr_d[l_ac].xmdr006,g_xmdr007) RETURNING l_inag008
                  IF l_inag008 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00017' #料件+產品特徵+庫存管理特徵+庫位+儲位不存在於[庫存明細檔]中！
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdr_d[l_ac].xmdr004 = g_xmdr_d_t.xmdr004
                     CALL s_desc_get_stock_desc(g_site,g_xmdr_d[l_ac].xmdr004) RETURNING g_xmdr_d[l_ac].xmdr004_desc
                     NEXT FIELD CURRENT                    
                  END IF                 
               END IF
               CALL s_desc_get_stock_desc(g_site,g_xmdr_d[l_ac].xmdr004) RETURNING g_xmdr_d[l_ac].xmdr004_desc
               LET g_xmdr_d[l_ac].xmdr010 = g_xmdr007
               CALL s_desc_get_unit_desc(g_xmdr_d[l_ac].xmdr010) RETURNING g_xmdr_d[l_ac].xmdr010_desc
               LET g_xmdr_d_t.xmdr004 = g_xmdr_d[l_ac].xmdr004
            ELSE
               LET g_xmdr_d[l_ac].xmdr004 = ' '
               LET g_xmdr_d[l_ac].xmdr004_desc = ''
               LET g_xmdr_d[l_ac].xmdr005 = ' '
               LET g_xmdr_d[l_ac].xmdr005_desc = ''
               LET g_xmdr_d[l_ac].xmdr006 = ' '
               LET g_xmdr_d[l_ac].xmdr003 = ' '               
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdr004
            #add-point:BEFORE FIELD xmdr004 name="input.b.page1.xmdr004"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdr004
            #add-point:ON CHANGE xmdr004 name="input.g.page1.xmdr004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdr005
            
            #add-point:AFTER FIELD xmdr005 name="input.a.page1.xmdr005"
            LET g_xmdr_d[l_ac].xmdr005_desc = ''
            IF NOT cl_null(g_xmdr_d[l_ac].xmdr005) THEN
               IF cl_null(g_xmdr_d[l_ac].xmdr004) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ain-00292' #庫位不可以為空！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xmdr_d[l_ac].xmdr005 = ' '
                  NEXT FIELD xmdr004                    
               END IF               
               IF (g_xmdr_d[l_ac].xmdr005 <> g_xmdr_d_t.xmdr005 OR g_xmdr_d_t.xmdr005 IS NULL) THEN
                  LET l_inag008 = 0
                  CALL axmt500_07_get_inag008(g_xmdr001,g_xmdr002,g_xmdr_d[l_ac].xmdr003,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005,g_xmdr_d[l_ac].xmdr006,g_xmdr007) RETURNING l_inag008
                  IF l_inag008 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00017' #料件+產品特徵+庫存管理特徵+庫位+儲位不存在於[庫存明細檔]中！
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdr_d[l_ac].xmdr005 = g_xmdr_d_t.xmdr005
                     CALL s_desc_get_locator_desc(g_site,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005) RETURNING g_xmdr_d[l_ac].xmdr005_desc              
                     NEXT FIELD CURRENT                  
                  END IF   
               END IF                  
               CALL s_desc_get_locator_desc(g_site,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005) RETURNING g_xmdr_d[l_ac].xmdr005_desc              
               LET g_xmdr_d_t.xmdr005 = g_xmdr_d[l_ac].xmdr005
            ELSE
               LET g_xmdr_d[l_ac].xmdr005 = ' '
               LET g_xmdr_d[l_ac].xmdr006 = ' '
               LET g_xmdr_d[l_ac].xmdr003 = ' '    
            END IF            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdr005
            #add-point:BEFORE FIELD xmdr005 name="input.b.page1.xmdr005"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdr005
            #add-point:ON CHANGE xmdr005 name="input.g.page1.xmdr005"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdr006
            #add-point:BEFORE FIELD xmdr006 name="input.b.page1.xmdr006"
           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdr006
            
            #add-point:AFTER FIELD xmdr006 name="input.a.page1.xmdr006"
            IF NOT cl_null(g_xmdr_d[l_ac].xmdr006) THEN
               IF cl_null(g_xmdr_d[l_ac].xmdr004) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00419' #請先維護庫位！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xmdr_d[l_ac].xmdr003 = ' '
                  NEXT FIELD xmdr004                    
               END IF
               IF cl_null(g_xmdr_d[l_ac].xmdr005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00281' #請先維護儲位！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xmdr_d[l_ac].xmdr003 = ' '
                  NEXT FIELD xmdr005                   
               END IF
               IF (g_xmdr_d[l_ac].xmdr006 <> g_xmdr_d_t.xmdr006 OR g_xmdr_d_t.xmdr006 IS NULL) THEN
                   LET l_inag008 = 0
                   CALL axmt500_07_get_inag008(g_xmdr001,g_xmdr002,g_xmdr_d[l_ac].xmdr003,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005,g_xmdr_d[l_ac].xmdr006,g_xmdr007) RETURNING l_inag008
                   IF l_inag008 <= 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'ain-00017' #料件+產品特徵+庫存管理特徵+庫位+儲位不存在於[庫存明細檔]中！
                      LET g_errparam.extend = ""
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET g_xmdr_d[l_ac].xmdr003 = ' '
                      NEXT FIELD CURRENT                  
                   END IF  
               END IF                   
            ELSE
               LET g_xmdr_d[l_ac].xmdr006 = ' '    
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdr006
            #add-point:ON CHANGE xmdr006 name="input.g.page1.xmdr006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdr003
            #add-point:BEFORE FIELD xmdr003 name="input.b.page1.xmdr003"
           
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdr003
            
            #add-point:AFTER FIELD xmdr003 name="input.a.page1.xmdr003"
            IF NOT cl_null(g_xmdr_d[l_ac].xmdr003) THEN
               IF cl_null(g_xmdr_d[l_ac].xmdr004) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00419' #請先維護庫位！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xmdr_d[l_ac].xmdr003 = ' '
                  NEXT FIELD xmdr004                    
               END IF
               IF cl_null(g_xmdr_d[l_ac].xmdr005) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'art-00281' #請先維護儲位！
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xmdr_d[l_ac].xmdr003 = ' '
                  NEXT FIELD xmdr005                   
               END IF
               IF (g_xmdr_d[l_ac].xmdr003 <> g_xmdr_d_t.xmdr003 OR g_xmdr_d_t.xmdr003 IS NULL) THEN
                  LET l_inag008 = 0
                  CALL axmt500_07_get_inag008(g_xmdr001,g_xmdr002,g_xmdr_d[l_ac].xmdr003,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005,g_xmdr_d[l_ac].xmdr006,g_xmdr007) RETURNING l_inag008
                  IF l_inag008 <= 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00017' #料件+產品特徵+庫存管理特徵+庫位+儲位不存在於[庫存明細檔]中！
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdr_d[l_ac].xmdr003 = ' '
                     NEXT FIELD CURRENT                  
                  END IF   
               END IF                  
            ELSE
               LET g_xmdr_d[l_ac].xmdr003 = ' '               
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdr003
            #add-point:ON CHANGE xmdr003 name="input.g.page1.xmdr003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdr008
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdr_d[l_ac].xmdr008,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdr008
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdr008 name="input.a.page1.xmdr008"
            IF NOT cl_null(g_xmdr_d[l_ac].xmdr008) AND (g_xmdr_d[l_ac].xmdr008 <> g_xmdr_d_t.xmdr008 OR g_xmdr_d_t.xmdr008 IS NULL) THEN
               #備置量不可大於訂單總備置量
               IF g_xmdr_d[l_ac].xmdr008 > g_xmdr008 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00307' 
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()        
                  LET g_xmdr_d[l_ac].xmdr008 = g_xmdr_d_t.xmdr008                  
                  NEXT FIELD CURRENT
               END IF
               #備置量不可小於備置已沖銷量！
               IF cl_null(g_xmdr_d[l_ac].xmdr009) THEN LET g_xmdr_d[l_ac].xmdr009 = 0 END IF
               IF g_xmdr_d[l_ac].xmdr009 > g_xmdr_d[l_ac].xmdr008 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00296' 
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()       
                  LET g_xmdr_d[l_ac].xmdr008 = g_xmdr_d_t.xmdr008                  
                  NEXT FIELD CURRENT            
               END IF
               #此庫儲批庫存量不足，無法備置！
               LET l_inag008 = 0
               CALL axmt500_07_get_inag008(g_xmdr001,g_xmdr002,g_xmdr_d[l_ac].xmdr003,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005,g_xmdr_d[l_ac].xmdr006,g_xmdr007) RETURNING l_inag008
               IF l_inag008 - g_xmdr_d[l_ac].xmdr008 < 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00801' 
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()       
                  LET g_xmdr_d[l_ac].xmdr008 = g_xmdr_d_t.xmdr008                  
                  NEXT FIELD CURRENT                 
               END IF
               LET g_xmdr_d_t.xmdr008 = g_xmdr_d[l_ac].xmdr008
            END IF   
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdr008
            #add-point:BEFORE FIELD xmdr008 name="input.b.page1.xmdr008"
 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdr008
            #add-point:ON CHANGE xmdr008 name="input.g.page1.xmdr008"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdr004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdr004
            #add-point:ON ACTION controlp INFIELD xmdr004 name="input.c.page1.xmdr004"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xmdr_d[l_ac].xmdr004 #庫位
            LET g_qryparam.default2 = g_xmdr_d[l_ac].xmdr005 #儲位
            LET g_qryparam.default3 = g_xmdr_d[l_ac].xmdr006 #批號
            LET g_qryparam.default4 = g_xmdr_d[l_ac].xmdr003 #庫存管理特徵
            LET g_qryparam.default5 = g_xmdr_d[l_ac].xmdr010 #庫存單位
            #給予arg
            LET g_qryparam.arg1 = g_xmdr001
            LET g_qryparam.arg2 = g_xmdr002
            LET g_qryparam.where = " inag007 ='",g_xmdr007,"'"
            CALL q_inag004_13()                                #呼叫開窗
 
            LET g_xmdr_d[l_ac].xmdr004 = g_qryparam.return1              
            LET g_xmdr_d[l_ac].xmdr005 = g_qryparam.return2 
            LET g_xmdr_d[l_ac].xmdr006 = g_qryparam.return3 
            LET g_xmdr_d[l_ac].xmdr003 = g_qryparam.return4 
            LET g_xmdr_d[l_ac].xmdr010 = g_qryparam.return5
            DISPLAY g_xmdr_d[l_ac].xmdr004 TO xmdr004 #庫位編號
            DISPLAY g_xmdr_d[l_ac].xmdr005 TO xmdr005 #儲位編號
            DISPLAY g_xmdr_d[l_ac].xmdr006 TO xmdr006 #批號
            DISPLAY g_xmdr_d[l_ac].xmdr003 TO xmdr003 #庫存管理特徵
            DISPLAY g_xmdr_d[l_ac].xmdr010 TO xmdr010 #庫存單位
            CALL s_desc_get_stock_desc(g_site,g_xmdr_d[l_ac].xmdr004) RETURNING g_xmdr_d[l_ac].xmdr004_desc
            CALL s_desc_get_locator_desc(g_site,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005) RETURNING g_xmdr_d[l_ac].xmdr005_desc           
            CALL s_desc_get_unit_desc(g_xmdr_d[l_ac].xmdr010) RETURNING g_xmdr_d[l_ac].xmdr010_desc
            DISPLAY BY NAME g_xmdr_d[l_ac].xmdr004_desc,g_xmdr_d[l_ac].xmdr005_desc,g_xmdr_d[l_ac].xmdr010_desc
            NEXT FIELD xmdr004                        #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdr005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdr005
            #add-point:ON ACTION controlp INFIELD xmdr005 name="input.c.page1.xmdr005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xmdr_d[l_ac].xmdr004 #庫位
            LET g_qryparam.default2 = g_xmdr_d[l_ac].xmdr005 #儲位
            LET g_qryparam.default3 = g_xmdr_d[l_ac].xmdr006 #批號
            LET g_qryparam.default4 = g_xmdr_d[l_ac].xmdr003 #庫存管理特徵
            LET g_qryparam.default5 = g_xmdr_d[l_ac].xmdr010 #庫存單位
            #給予arg
            LET g_qryparam.arg1 = g_xmdr001
            LET g_qryparam.arg2 = g_xmdr002
            LET g_qryparam.where = " inag007 ='",g_xmdr007,"'"
            CALL q_inag004_13()                                #呼叫開窗
 
            LET g_xmdr_d[l_ac].xmdr004 = g_qryparam.return1              
            LET g_xmdr_d[l_ac].xmdr005 = g_qryparam.return2 
            LET g_xmdr_d[l_ac].xmdr006 = g_qryparam.return3 
            LET g_xmdr_d[l_ac].xmdr003 = g_qryparam.return4 
            LET g_xmdr_d[l_ac].xmdr010 = g_qryparam.return5
            DISPLAY g_xmdr_d[l_ac].xmdr004 TO xmdr004 #庫位編號
            DISPLAY g_xmdr_d[l_ac].xmdr005 TO xmdr005 #儲位編號
            DISPLAY g_xmdr_d[l_ac].xmdr006 TO xmdr006 #批號
            DISPLAY g_xmdr_d[l_ac].xmdr003 TO xmdr003 #庫存管理特徵
            DISPLAY g_xmdr_d[l_ac].xmdr010 TO xmdr010 #庫存單位
            CALL s_desc_get_stock_desc(g_site,g_xmdr_d[l_ac].xmdr004) RETURNING g_xmdr_d[l_ac].xmdr004_desc
            CALL s_desc_get_locator_desc(g_site,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005) RETURNING g_xmdr_d[l_ac].xmdr005_desc           
            CALL s_desc_get_unit_desc(g_xmdr_d[l_ac].xmdr010) RETURNING g_xmdr_d[l_ac].xmdr010_desc
            DISPLAY BY NAME g_xmdr_d[l_ac].xmdr004_desc,g_xmdr_d[l_ac].xmdr005_desc,g_xmdr_d[l_ac].xmdr010_desc       
            NEXT FIELD xmdr005                        #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdr006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdr006
            #add-point:ON ACTION controlp INFIELD xmdr006 name="input.c.page1.xmdr006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xmdr_d[l_ac].xmdr004 #庫位
            LET g_qryparam.default2 = g_xmdr_d[l_ac].xmdr005 #儲位
            LET g_qryparam.default3 = g_xmdr_d[l_ac].xmdr006 #批號
            LET g_qryparam.default4 = g_xmdr_d[l_ac].xmdr003 #庫存管理特徵
            LET g_qryparam.default5 = g_xmdr_d[l_ac].xmdr010 #庫存單位
            #給予arg
            LET g_qryparam.arg1 = g_xmdr001
            LET g_qryparam.arg2 = g_xmdr002
            LET g_qryparam.where = " inag007 ='",g_xmdr007,"'"
            CALL q_inag004_13()                                #呼叫開窗
 
            LET g_xmdr_d[l_ac].xmdr004 = g_qryparam.return1              
            LET g_xmdr_d[l_ac].xmdr005 = g_qryparam.return2 
            LET g_xmdr_d[l_ac].xmdr006 = g_qryparam.return3 
            LET g_xmdr_d[l_ac].xmdr003 = g_qryparam.return4 
            LET g_xmdr_d[l_ac].xmdr010 = g_qryparam.return5
            DISPLAY g_xmdr_d[l_ac].xmdr004 TO xmdr004 #庫位編號
            DISPLAY g_xmdr_d[l_ac].xmdr005 TO xmdr005 #儲位編號
            DISPLAY g_xmdr_d[l_ac].xmdr006 TO xmdr006 #批號
            DISPLAY g_xmdr_d[l_ac].xmdr003 TO xmdr003 #庫存管理特徵
            DISPLAY g_xmdr_d[l_ac].xmdr010 TO xmdr010 #庫存單位
            CALL s_desc_get_stock_desc(g_site,g_xmdr_d[l_ac].xmdr004) RETURNING g_xmdr_d[l_ac].xmdr004_desc
            CALL s_desc_get_locator_desc(g_site,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005) RETURNING g_xmdr_d[l_ac].xmdr005_desc           
            CALL s_desc_get_unit_desc(g_xmdr_d[l_ac].xmdr010) RETURNING g_xmdr_d[l_ac].xmdr010_desc
            DISPLAY BY NAME g_xmdr_d[l_ac].xmdr004_desc,g_xmdr_d[l_ac].xmdr005_desc,g_xmdr_d[l_ac].xmdr010_desc         
            NEXT FIELD xmdr006                        #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdr003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdr003
            #add-point:ON ACTION controlp INFIELD xmdr003 name="input.c.page1.xmdr003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_xmdr_d[l_ac].xmdr004 #庫位
            LET g_qryparam.default2 = g_xmdr_d[l_ac].xmdr005 #儲位
            LET g_qryparam.default3 = g_xmdr_d[l_ac].xmdr006 #批號
            LET g_qryparam.default4 = g_xmdr_d[l_ac].xmdr003 #庫存管理特徵
            LET g_qryparam.default5 = g_xmdr_d[l_ac].xmdr010 #庫存單位
            #給予arg
            LET g_qryparam.arg1 = g_xmdr001
            LET g_qryparam.arg2 = g_xmdr002
            LET g_qryparam.where = " inag007 ='",g_xmdr007,"'"
            CALL q_inag004_13()                                #呼叫開窗
 
            LET g_xmdr_d[l_ac].xmdr004 = g_qryparam.return1              
            LET g_xmdr_d[l_ac].xmdr005 = g_qryparam.return2 
            LET g_xmdr_d[l_ac].xmdr006 = g_qryparam.return3 
            LET g_xmdr_d[l_ac].xmdr003 = g_qryparam.return4 
            LET g_xmdr_d[l_ac].xmdr010 = g_qryparam.return5
            DISPLAY g_xmdr_d[l_ac].xmdr004 TO xmdr004 #庫位編號
            DISPLAY g_xmdr_d[l_ac].xmdr005 TO xmdr005 #儲位編號
            DISPLAY g_xmdr_d[l_ac].xmdr006 TO xmdr006 #批號
            DISPLAY g_xmdr_d[l_ac].xmdr003 TO xmdr003 #庫存管理特徵
            DISPLAY g_xmdr_d[l_ac].xmdr010 TO xmdr010 #庫存單位
            CALL s_desc_get_stock_desc(g_site,g_xmdr_d[l_ac].xmdr004) RETURNING g_xmdr_d[l_ac].xmdr004_desc
            CALL s_desc_get_locator_desc(g_site,g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr005) RETURNING g_xmdr_d[l_ac].xmdr005_desc           
            CALL s_desc_get_unit_desc(g_xmdr_d[l_ac].xmdr010) RETURNING g_xmdr_d[l_ac].xmdr010_desc
            DISPLAY BY NAME g_xmdr_d[l_ac].xmdr004_desc,g_xmdr_d[l_ac].xmdr005_desc,g_xmdr_d[l_ac].xmdr010_desc         
            NEXT FIELD xmdr003                        #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdr008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdr008
            #add-point:ON ACTION controlp INFIELD xmdr008 name="input.c.page1.xmdr008"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF NOT axmt500_07_chk() THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'axm-00800' #備置量總合需等於訂單總備置量！
               LET g_errparam.extend = "xmdr008"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD xmdr008             
            END IF
            CALL axmt500_07_gen_xmdr()
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_xmdr2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)

         BEFORE ROW
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            LET g_detail_idx = l_ac
            DISPLAY g_detail_idx TO FORMONLY.idx
            DISPLAY g_xmdr2_d.getLength() TO FORMONLY.cnt

         BEFORE DISPLAY
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET l_ac = DIALOG.getCurrentRow("s_detail2")
            DISPLAY g_detail_idx TO FORMONLY.idx
            DISPLAY g_xmdr2_d.getLength() TO FORMONLY.cnt
      END DISPLAY    
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
   CLOSE WINDOW w_axmt500_07 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 9001
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET INT_FLAG = 0 
      LET g_success = FALSE           
   END IF 
   RETURN g_success,g_xmdr
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt500_07.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt500_07.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt500_07_b_fill()
DEFINE l_sql      STRING
DEFINE l_ac       LIKE type_t.num5
DEFINE i          LIKE type_t.num5
DEFINE l_cnt      LIKE type_t.num5
DEFINE l_inan010  LIKE inan_t.inan010 



   CALL g_xmdr_d.clear()
   
   LET l_sql = "SELECT xmdr004,t1.inaa002,    xmdr005,t2.inab003,xmdr006,",
               "       xmdr003,   xmdr010,t3.oocal003,   xmdr008,xmdr009 ",              
               "  FROM xmdr_t LEFT JOIN inaa_t t1 ON t1.inaaent="||g_enterprise||" AND t1.inaasite = xmdrsite AND t1.inaa001=xmdr004 ",
               "              LEFT JOIN inab_t t2 ON t2.inabent="||g_enterprise||" AND t2.inabsite = xmdrsite AND t2.inab001=xmdr004 AND t2.inab002=xmdr005 ",
               "              LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=xmdr010 AND t3.oocal002='"||g_dlang||"' ",
               " WHERE xmdrent = ",g_enterprise,
               "   AND xmdrsite = '",g_site,"'",
               "   AND xmdrdocno = '",g_xmdrdocno,"' AND xmdrseq = '",g_xmdrseq,"'",
               "   AND xmdrseq1 = '",g_xmdrseq1,"' AND xmdrseq2 = '",g_xmdrseq2,"'"
   PREPARE b_fill_sel FROM l_sql
   DECLARE b_fill_curs CURSOR FOR b_fill_sel
   LET l_ac = 1
   FOREACH b_fill_curs INTO g_xmdr_d[l_ac].xmdr004,g_xmdr_d[l_ac].xmdr004_desc,g_xmdr_d[l_ac].xmdr005,g_xmdr_d[l_ac].xmdr005_desc,g_xmdr_d[l_ac].xmdr006,
                            g_xmdr_d[l_ac].xmdr003,g_xmdr_d[l_ac].xmdr010,g_xmdr_d[l_ac].xmdr010_desc,g_xmdr_d[l_ac].xmdr008,g_xmdr_d[l_ac].xmdr009

        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "FOREACH:b_fill_curs"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           EXIT FOREACH
        END IF
        IF cl_null(g_xmdr_d[l_ac].xmdr009) THEN LET g_xmdr_d[l_ac].xmdr009 = 0 END IF

        LET l_ac = l_ac + 1
        IF l_ac > g_max_rec THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code =  9035
           LET g_errparam.extend =  ''
           LET g_errparam.popup = FALSE
           CALL cl_err()
           EXIT FOREACH
        END IF    
   
   END FOREACH   
   CALL g_xmdr_d.deleteElement(g_xmdr_d.getLength())
   
   
   LET l_sql = "SELECT SUM(inan010) FROM inan_t ",
               " WHERE inanent = ",g_enterprise,
               "   AND inansite = '",g_site,"'",
               "   AND inan001 = ? AND COALESCE(inan002,' ') = COALESCE(?,' ') ",
               "   AND COALESCE(inan003,' ') = COALESCE(?,' ') AND COALESCE(inan004,' ') = COALESCE(?,' ') ",
               "   AND COALESCE(inan005,' ') = COALESCE(?,' ') AND COALESCE(inan006,' ') = COALESCE(?,' ') ",
               "   AND inan007 = ? "
   PREPARE axmt500_07_p1 FROM l_sql
   
   
   CALL g_xmdr2_d.clear()
   LET l_sql = "SELECT UNIQUE inag004,t1.inaa002,inag005,t2.inab003, inag006, ",
               "              inag003,        '',inag007,t3.oocal003,inag008  ",
               "  FROM inag_t LEFT JOIN inaa_t t1 ON t1.inaaent="||g_enterprise||" AND t1.inaasite=inagsite AND t1.inaa001=inag004 ",
               "              LEFT JOIN inab_t t2 ON t2.inabent="||g_enterprise||" AND t2.inabsite=inagsite AND t2.inab001=inag004 AND t2.inab002=inag005 ",
               "              LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=inag007 AND t3.oocal002='"||g_dlang||"' ",
               " WHERE inagent = ",g_enterprise,
               "   AND inagsite = '",g_site,"'",
               "   AND inag001 = ? AND COALESCE(inag002,' ') = COALESCE(?,' ') ",
               "   AND inag007 = ? AND inag008 > 0 ",
               " ORDER BY inag004,inag005,inag006,inag007"
                      
   PREPARE b_fill_sel2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR b_fill_sel2
   
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_xmdr001,g_xmdr002,g_xmdr007 INTO g_xmdr2_d[l_ac].inag004,g_xmdr2_d[l_ac].inag004_desc,g_xmdr2_d[l_ac].inag005,g_xmdr2_d[l_ac].inag005_desc,g_xmdr2_d[l_ac].inag006,
                                                                 g_xmdr2_d[l_ac].inag003,g_xmdr2_d[l_ac].inad011,g_xmdr2_d[l_ac].inag007,g_xmdr2_d[l_ac].inag007_desc,g_xmdr2_d[l_ac].inag008

        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "FOREACH:b_fill_curs2"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           EXIT FOREACH
        END IF
        
        #帶出該料件之可用庫存資料，庫存可用量需扣除在揀跟備置
        LET l_inan010 = 0
        EXECUTE axmt500_07_p1 USING g_xmdr001,g_xmdr002,g_xmdr2_d[l_ac].inag003,g_xmdr2_d[l_ac].inag004,g_xmdr2_d[l_ac].inag005,g_xmdr2_d[l_ac].inag006,g_xmdr007 INTO l_inan010
        IF cl_null(l_inan010) THEN LET l_inan010 = 0 END IF        
        IF cl_null(g_xmdr2_d[l_ac].inag008) THEN LET g_xmdr2_d[l_ac].inag008 = 0 END IF
        LET g_xmdr2_d[l_ac].inag008 = g_xmdr2_d[l_ac].inag008 - l_inan010
        IF g_xmdr2_d[l_ac].inag008 <= 0 THEN
           CONTINUE FOREACH
        END IF
        
        LET l_ac = l_ac + 1
        IF l_ac > g_max_rec THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code =  9035
           LET g_errparam.extend =  ''
           LET g_errparam.popup = FALSE
           CALL cl_err()
           EXIT FOREACH
        END IF  

   END FOREACH   
   CALL g_xmdr2_d.deleteElement(g_xmdr2_d.getLength())

END FUNCTION

################################################################################
# Descriptions...: 可備置量控卡
# Memo...........:
# Usage..........: CALL axmt500_07_get_inag008(p_inag001,p_inag002,p_inag003,p_inag004,p_inag005,p_inag006,p_inag007)
#                  RETURNING r_inag008
# Input parameter: p_inag001      料號
#                : p_inag002      產品特徵
#                : p_inag003      庫存管理特徵
#                : p_inag004      庫位編號
#                : p_inag005      儲位編號
#                : p_inag006      批號
#                : p_inag007      庫存單位
# Return code....: r_inag008      可備置量
# Date & Author..: 160822-00001#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt500_07_get_inag008(p_inag001,p_inag002,p_inag003,p_inag004,p_inag005,p_inag006,p_inag007)
DEFINE p_inag001  LIKE inag_t.inag001
DEFINE p_inag002  LIKE inag_t.inag002
DEFINE p_inag003  LIKE inag_t.inag003
DEFINE p_inag004  LIKE inag_t.inag004
DEFINE p_inag005  LIKE inag_t.inag005
DEFINE p_inag006  LIKE inag_t.inag006
DEFINE p_inag007  LIKE inag_t.inag007
DEFINE l_inag008  LIKE inag_t.inag008
DEFINE l_inan010  LIKE inan_t.inan010
DEFINE r_inag008  LIKE inag_t.inag008
DEFINE l_sql      STRING

   LET r_inag008 = 0
   
   IF cl_null(p_inag001) OR cl_null(p_inag007) THEN
      RETURN r_inag008
   END IF
   #庫存量
   LET l_sql = "SELECT SUM(inag008) FROM inag_t ",
               " WHERE inagent = ",g_enterprise,
               "   AND inagsite = '",g_site,"'",
               "   AND inag001 = ? AND COALESCE(inag002,' ') = COALESCE(?,' ') ",
               "   AND inag007 = ? "
   IF NOT cl_null(p_inag003) THEN 
      LET l_sql = l_sql," AND inag003 = '",p_inag003,"'"
   END IF   
   IF NOT cl_null(p_inag004) THEN 
      LET l_sql = l_sql," AND inag004 = '",p_inag004,"'"
   END IF
   IF NOT cl_null(p_inag005) THEN 
      LET l_sql = l_sql," AND inag005 = '",p_inag005,"'"
   END IF
   IF NOT cl_null(p_inag006) THEN 
      LET l_sql = l_sql," AND inag006 = '",p_inag006,"'"
   END IF
   PREPARE axmt500_07_inag_p1 FROM l_sql
   LET l_inag008 = 0
   EXECUTE axmt500_07_inag_p1 USING p_inag001,p_inag002,p_inag007 INTO l_inag008
   IF cl_null(l_inag008) THEN LET l_inag008 = 0 END IF
   
   #在揀量、備置量
   LET l_sql = "SELECT SUM(inan010) FROM inan_t ",
               " WHERE inanent = ",g_enterprise,
               "   AND inansite = '",g_site,"'",
               "   AND inan001 = ? AND COALESCE(inan002,' ') = COALESCE(?,' ') ",
               "   AND inan007 = ? "
     
   IF NOT cl_null(p_inag003) THEN 
      LET l_sql = l_sql," AND inan003 = '",p_inag003,"'"
   END IF   
   IF NOT cl_null(p_inag004) THEN 
      LET l_sql = l_sql," AND inan004 = '",p_inag004,"'"
   END IF
   IF NOT cl_null(p_inag005) THEN 
      LET l_sql = l_sql," AND inan005 = '",p_inag005,"'"
   END IF
   IF NOT cl_null(p_inag006) THEN 
      LET l_sql = l_sql," AND inan006 = '",p_inag006,"'"
   END IF
   PREPARE axmt500_07_inan_p1 FROM l_sql 
   LET l_inan010 = 0
   EXECUTE axmt500_07_inan_p1 USING p_inag001,p_inag002,p_inag007 INTO l_inan010
   IF cl_null(l_inan010) THEN LET l_inan010 = 0 END IF   
   
   LET r_inag008 = l_inag008 - l_inan010
   RETURN r_inag008
   
END FUNCTION

################################################################################
# Descriptions...: 資料檢核
# Memo...........:
# Usage..........: CALL axmt500_07_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 160822-00001#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt500_07_chk()
DEFINE i            LIKE type_t.num5
DEFINE l_qty        LIKE xmdr_t.xmdr008
DEFINE r_success    LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5

   LET l_qty = 0
   LET r_success = TRUE
   FOR i = 1 TO g_xmdr_d.getLength()
       IF cl_null(g_xmdr_d[i].xmdr003) THEN LET g_xmdr_d[i].xmdr003 = ' ' END IF
       IF cl_null(g_xmdr_d[i].xmdr004) THEN LET g_xmdr_d[i].xmdr004 = ' ' END IF
       IF cl_null(g_xmdr_d[i].xmdr005) THEN LET g_xmdr_d[i].xmdr005 = ' ' END IF
       IF cl_null(g_xmdr_d[i].xmdr006) THEN LET g_xmdr_d[i].xmdr006 = ' ' END IF       
       IF cl_null(g_xmdr_d[i].xmdr008) THEN LET g_xmdr_d[i].xmdr008 = 0 END IF 
       
       LET l_qty = l_qty + g_xmdr_d[i].xmdr008       
   END FOR
   IF cl_null(l_qty) THEN LET l_qty = 0 END IF
   IF l_qty <> g_xmdr008 THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
   
   
END FUNCTION

################################################################################
# Descriptions...: 產生訂單備置明細檔
# Memo...........:
# Usage..........: CALL axmt500_07_gen_xmdr()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160822-00001#1 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt500_07_gen_xmdr()
DEFINE i            LIKE type_t.num5
DEFINE j            LIKE type_t.num5
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE
   LET j = 1
   CALL g_xmdr.clear()
   FOR i = 1 TO g_xmdr_d.getLength()
       IF g_xmdr_d[i].xmdr008 > 0 THEN
          LET g_xmdr[j].xmdr008 = g_xmdr_d[i].xmdr008
          LET g_xmdr[j].xmdr009 = g_xmdr_d[i].xmdr009
          LET g_xmdr[j].xmdr010 = g_xmdr_d[i].xmdr010
          LET g_xmdr[j].xmdr004 = g_xmdr_d[i].xmdr004
          LET g_xmdr[j].xmdr005 = g_xmdr_d[i].xmdr005
          LET g_xmdr[j].xmdr003 = g_xmdr_d[i].xmdr003
          LET g_xmdr[j].xmdr006 = g_xmdr_d[i].xmdr006
          LET g_xmdr[j].xmdr007 = g_xmdr007
          LET j = j + 1
       END IF
   END FOR  
   CALL g_xmdr.deleteElement(j)
   
END FUNCTION

PRIVATE FUNCTION axmt500_07_set_entry()
   CALL cl_set_comp_entry("xmdr003,xmdr004,xmdr005,xmdr006",TRUE)
END FUNCTION

PRIVATE FUNCTION axmt500_07_set_no_entry()
   IF g_xmdr_d[l_ac].xmdr009 > 0 THEN
      CALL cl_set_comp_entry("xmdr003,xmdr004,xmdr005,xmdr006",FALSE)
   END IF
END FUNCTION

 
{</section>}
 

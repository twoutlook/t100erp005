#該程式未解開Section, 採用最新樣板產出!
{<section id="agli190_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-06-29 13:38:41), PR版次:0009(2016-10-21 19:17:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000210
#+ Filename...: agli190_01
#+ Description: 款別編號科目設定
#+ Creator....: 02291(2013-11-08 00:00:00)
#+ Modifier...: 02114 -SD/PR- 06821
 
{</section>}
 
{<section id="agli190_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#28  160325 By Jessy      修正azzi920重複定義之錯誤訊息
#160509-00004#3   160509 by 02114      增加往来科目(流通)与代收银科目(流通)的二个栏位
#160509-00004#91  160509 by 02114      款别的代收银科目里面再增加一个栏位，为代收银收款科目（借方）,即有代收银据点时，可以设定借方与贷方科目
#161021-00037#1   161021 By 06821      組織類型與職能開窗調整
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
PRIVATE type type_g_glab_m        RECORD
       glab003 LIKE glab_t.glab003, 
   glab003_desc LIKE type_t.chr80, 
   ooia002 LIKE type_t.chr500, 
   glab005 LIKE glab_t.glab005, 
   glab005_desc LIKE type_t.chr80, 
   glab006 LIKE glab_t.glab006, 
   glab006_desc LIKE type_t.chr80, 
   glab007 LIKE glab_t.glab007, 
   glab007_desc LIKE type_t.chr80, 
   glab008 LIKE glab_t.glab008, 
   glab008_desc LIKE type_t.chr80, 
   glab014 LIKE glab_t.glab014, 
   glab014_desc LIKE type_t.chr80, 
   glab015 LIKE glab_t.glab015, 
   glab015_desc LIKE type_t.chr80, 
   glab016 LIKE glab_t.glab016, 
   glab016_desc LIKE type_t.chr80, 
   glab009 LIKE glab_t.glab009, 
   glab009_desc LIKE type_t.chr80, 
   glab011 LIKE glab_t.glab011, 
   glab002 LIKE glab_t.glab002, 
   glab001 LIKE glab_t.glab001, 
   glabld LIKE glab_t.glabld
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glab_m_t        type_g_glab_m
DEFINE g_glab004         LIKE glab_t.glab004

#end add-point
 
DEFINE g_glab_m        type_g_glab_m
 
   DEFINE g_glab003_t LIKE glab_t.glab003
DEFINE g_glab002_t LIKE glab_t.glab002
DEFINE g_glab001_t LIKE glab_t.glab001
DEFINE g_glabld_t LIKE glab_t.glabld
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="agli190_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli190_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_glabld,p_glab002,p_glab003
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
   DEFINE p_glabld        LIKE glab_t.glabld
   DEFINE p_glab002       LIKE glab_t.glab002
   DEFINE p_glab003       LIKE glab_t.glab003
   DEFINE l_glab011       LIKE glab_t.glab011
   DEFINE l_glaa004       LIKE glaa_t.glaa004  #150916-00015#1 -add   
   DEFINE l_comp          LIKE glaa_t.glaacomp #160509-00004#78 add lujh
   DEFINE l_success       LIKE type_t.num5     #160509-00004#78 add lujh
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli190_01 WITH FORM cl_ap_formpath("agl","agli190_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   INITIALIZE g_glab_m.* TO NULL
   CALL cl_set_combo_scc('glab011','8315')
   LET g_glab_m.glab011 = '1'
   DISPLAY g_glab_m.glab011 TO glab011
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glab_m.glab003,g_glab_m.glab005,g_glab_m.glab006,g_glab_m.glab007,g_glab_m.glab008, 
          g_glab_m.glab014,g_glab_m.glab015,g_glab_m.glab016,g_glab_m.glab009,g_glab_m.glab011,g_glab_m.glab002, 
          g_glab_m.glab001,g_glab_m.glabld ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_glab_m.glabld = p_glabld
            LET g_glab_m.glab001 = '21'
            LET g_glab_m.glab002 = p_glab002
            LET g_glab_m.glab003 = p_glab003
            CALL agli190_01_glab_ref() RETURNING g_glab_m.ooia002,g_glab_m.glab003_desc
            LET g_glab_m.ooia002 = p_glab002,"(",g_glab_m.ooia002,")"
            DISPLAY BY NAME g_glab_m.ooia002
            SELECT unique glab005,glab006,glab007,glab008,glab009,glab011,  #160509-00004#3 add glab008,glab009 lujh   
                          glab014,glab015,glab016       #160509-00004#78 add lujh   #160509-00004#91 add glab016 lujh
              INTO g_glab_m.glab005,g_glab_m.glab006,g_glab_m.glab007,
                   g_glab_m.glab008,g_glab_m.glab009,g_glab_m.glab011,   #160509-00004#3 add g_glab_m.glab008,g_glab_m.glab009 lujh
                   g_glab_m.glab014,g_glab_m.glab015,g_glab_m.glab016    #160509-00004#78 add lujh  #160509-00004#91 add g_glab_m.glab016 lujh
              FROM glab_t
             WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = '21' 
               AND glab002 = g_glab_m.glab002 AND glab003 = g_glab_m.glab003
            IF cl_null(g_glab_m.glab011) THEN
               LET g_glab_m.glab011 = '1'
            END IF
            SELECT unique glab004 INTO g_glab004 FROM glab_t 
             WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = '21'
            CALL agli190_01_glacl004(g_glab_m.glab005) RETURNING g_glab_m.glab005_desc
            CALL agli190_01_glacl004(g_glab_m.glab006) RETURNING g_glab_m.glab006_desc
            CALL agli190_01_glacl004(g_glab_m.glab007) RETURNING g_glab_m.glab007_desc
            #160509-00004#3--add--str--lujh
            CALL agli190_01_glacl004(g_glab_m.glab008) RETURNING g_glab_m.glab008_desc
            CALL agli190_01_glacl004(g_glab_m.glab009) RETURNING g_glab_m.glab009_desc
            #160509-00004#3--add--end--lujh
            CALL agli190_01_glacl004(g_glab_m.glab016) RETURNING g_glab_m.glab016_desc     #160509-00004#91 add lujh
            #160509-00004#78--add--str--lujh
            CALL s_desc_get_department_desc(g_glab_m.glab014) RETURNING g_glab_m.glab014_desc
            DISPLAY g_glab_m.glab014_desc TO glab014_desc
            CALL s_desc_get_ld_desc(g_glab_m.glab015) RETURNING g_glab_m.glab015_desc
            DISPLAY g_glab_m.glab015_desc TO glab015_desc
            #160509-00004#78--add--end--lujh
            DISPLAY g_glab_m.glab011 TO glab011           
            DISPLAY BY NAME g_glab_m.glab005_desc
            DISPLAY BY NAME g_glab_m.glab006_desc
            DISPLAY BY NAME g_glab_m.glab007_desc
            #160509-00004#3--add--str--lujh
            DISPLAY BY NAME g_glab_m.glab008_desc
            DISPLAY BY NAME g_glab_m.glab009_desc
            #160509-00004#3--add--end--lujh
            DISPLAY BY NAME g_glab_m.glab016_desc   #160509-00004#91 add lujh
            DISPLAY BY NAME g_glab_m.glab003_desc
            LET g_glab_m_t.* = g_glab_m.*
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab003
            
            #add-point:AFTER FIELD glab003 name="input.a.glab003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glab_m.glabld) AND NOT cl_null(g_glab_m.glab001) AND NOT cl_null(g_glab_m.glab002) AND NOT cl_null(g_glab_m.glab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glab_m.glabld != g_glabld_t  OR g_glab_m.glab001 != g_glab001_t  OR g_glab_m.glab002 != g_glab002_t  OR g_glab_m.glab003 != g_glab003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glab_m.glabld ||"' AND "|| "glab001 = '"||g_glab_m.glab001 ||"' AND "|| "glab002 = '"||g_glab_m.glab002 ||"' AND "|| "glab003 = '"||g_glab_m.glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab003
            #add-point:BEFORE FIELD glab003 name="input.b.glab003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab003
            #add-point:ON CHANGE glab003 name="input.g.glab003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab005
            
            #add-point:AFTER FIELD glab005 name="input.a.glab005"
            #151117-00009#1--mod--str--
            IF NOT cl_null(g_glab_m.glab005) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab_m.glab005,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glabld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_m.glab005
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_m.glab005
                  LET g_qryparam.arg3 = g_glab_m.glabld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET g_glab_m.glab005 = g_qryparam.return1
                  CALL agli190_01_glacl004(g_glab_m.glab005) RETURNING g_glab_m.glab005_desc             
                  DISPLAY g_glab_m.glab005 TO glab005              #顯示到畫面上
                  DISPLAY BY NAME g_glab_m.glab005_desc
                    
               END IF
               # 150916-00015#1 --end
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glab_m.glabld,g_glab_m.glab005)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glab_m.glab005
                  #160321-00016#28 --s add
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  #160321-00016#28 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glab_m.glab005 = g_glab_m_t.glab005
                  CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_m.glab005) RETURNING g_glab_m.glab005_desc
                  DISPLAY BY NAME g_glab_m.glab005_desc
                  NEXT FIELD CURRENT                  
               END IF
#            IF NOT agli190_01_glab_chk(g_glab_m.glab005) THEN
#               LET g_glab_m.glab005 = g_glab_m_t.glab005
#               LET g_glab_m.glab005_desc = g_glab_m_t.glab005_desc
#               DISPLAY BY NAME g_glab_m.glab005_desc
#               NEXT FIELD glab005
#            ELSE
               IF cl_null(g_glab_m.glab006) THEN 
                  LET g_glab_m.glab006 = g_glab_m.glab005 
                  CALL agli190_01_glacl004(g_glab_m.glab006) RETURNING g_glab_m.glab006_desc
                  DISPLAY BY NAME g_glab_m.glab006_desc
               END IF
               IF cl_null(g_glab_m.glab007) THEN 
                  LET g_glab_m.glab007 = g_glab_m.glab005 
                  CALL agli190_01_glacl004(g_glab_m.glab007) RETURNING g_glab_m.glab007_desc
                  DISPLAY BY NAME g_glab_m.glab007_desc
               END IF
               #160509-00004#3--add--str--lujh
               IF cl_null(g_glab_m.glab008) THEN 
                  LET g_glab_m.glab008 = g_glab_m.glab005 
                  CALL agli190_01_glacl004(g_glab_m.glab008) RETURNING g_glab_m.glab008_desc
                  DISPLAY BY NAME g_glab_m.glab008_desc
               END IF
               IF cl_null(g_glab_m.glab009) THEN 
                  LET g_glab_m.glab009 = g_glab_m.glab005 
                  CALL agli190_01_glacl004(g_glab_m.glab009) RETURNING g_glab_m.glab009_desc
                  DISPLAY BY NAME g_glab_m.glab009_desc
               END IF
               #160509-00004#3--add--end--lujh
               #160509-00004#91--add--str--lujh
               IF cl_null(g_glab_m.glab016) THEN 
                  LET g_glab_m.glab016 = g_glab_m.glab005 
                  CALL agli190_01_glacl004(g_glab_m.glab016) RETURNING g_glab_m.glab016_desc
                  DISPLAY BY NAME g_glab_m.glab016_desc
               END IF
               #160509-00004#91--add--end--lujh
            END IF
            #151117-00009#1--mod--end
            CALL agli190_01_glacl004(g_glab_m.glab005) RETURNING g_glab_m.glab005_desc
            DISPLAY BY NAME g_glab_m.glab005_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab005
            #add-point:BEFORE FIELD glab005 name="input.b.glab005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab005
            #add-point:ON CHANGE glab005 name="input.g.glab005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab006
            
            #add-point:AFTER FIELD glab006 name="input.a.glab006"
            #151117-00009#1--mod--str--
            IF NOT cl_null(g_glab_m.glab006) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab_m.glab006,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glabld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_m.glab006
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_m.glab006
                  LET g_qryparam.arg3 = g_glab_m.glabld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab_m.glab006 = g_qryparam.return1  
                  CALL agli190_01_glacl004(g_glab_m.glab006) RETURNING g_glab_m.glab006_desc             
                  DISPLAY g_glab_m.glab006 TO glab006              #顯示到畫面上
                  DISPLAY BY NAME g_glab_m.glab006_desc
                         
               END IF
               # 150916-00015#1 --end
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glab_m.glabld,g_glab_m.glab006)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glab_m.glab006
                  #160321-00016#28 --s add
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  #160321-00016#28 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glab_m.glab006 = g_glab_m_t.glab006
                  CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_m.glab006) RETURNING g_glab_m.glab006_desc
                  DISPLAY BY NAME g_glab_m.glab006_desc
                  NEXT FIELD CURRENT                  
               END IF
#            IF NOT agli190_01_glab_chk(g_glab_m.glab006) THEN
#               LET g_glab_m.glab006 = g_glab_m_t.glab006
#               LET g_glab_m.glab006_desc = g_glab_m_t.glab006_desc
#               DISPLAY BY NAME g_glab_m.glab006_desc
#               NEXT FIELD glab006
#            END IF
            END IF
            #151117-00009#1--mod--end
            CALL agli190_01_glacl004(g_glab_m.glab006) RETURNING g_glab_m.glab006_desc
            DISPLAY BY NAME g_glab_m.glab006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab006
            #add-point:BEFORE FIELD glab006 name="input.b.glab006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab006
            #add-point:ON CHANGE glab006 name="input.g.glab006"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab007
            
            #add-point:AFTER FIELD glab007 name="input.a.glab007"
            #151117-00009#1--mod--str--
            IF NOT cl_null(g_glab_m.glab007) THEN
               # 开窗模糊查询 150916-00015#1 --add                      
               IF s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab_m.glab007,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glabld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_m.glab007
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_m.glab007
                  LET g_qryparam.arg3 = g_glab_m.glabld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab_m.glab007 = g_qryparam.return1   
                  CALL agli190_01_glacl004(g_glab_m.glab007) RETURNING g_glab_m.glab007_desc             
                  DISPLAY g_glab_m.glab007 TO glab007             #顯示到畫面上
                  DISPLAY BY NAME g_glab_m.glab007_desc
                        
               END IF
               # 150916-00015#1 --end
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glab_m.glabld,g_glab_m.glab007)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glab_m.glab007
                  #160321-00016#28 --s add
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  #160321-00016#28 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glab_m.glab007 = g_glab_m_t.glab007
                  CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_m.glab007) RETURNING g_glab_m.glab007_desc
                  DISPLAY BY NAME g_glab_m.glab007_desc
                  NEXT FIELD CURRENT                  
               END IF
#            IF NOT agli190_01_glab_chk(g_glab_m.glab007) THEN
#               LET g_glab_m.glab007 = g_glab_m_t.glab007
#               LET g_glab_m.glab007_desc = g_glab_m_t.glab007_desc
#               DISPLAY BY NAME g_glab_m.glab007_desc
#               NEXT FIELD glab007
#            END IF
            END IF
            #151117-00009#1--mod--end
            CALL agli190_01_glacl004(g_glab_m.glab007) RETURNING g_glab_m.glab007_desc
            DISPLAY BY NAME g_glab_m.glab007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab007
            #add-point:BEFORE FIELD glab007 name="input.b.glab007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab007
            #add-point:ON CHANGE glab007 name="input.g.glab007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab008
            
            #add-point:AFTER FIELD glab008 name="input.a.glab008"
            #160509-00004#3--add--str--lujh
            IF NOT cl_null(g_glab_m.glab008) THEN                    
               IF s_aglt310_getlike_lc_subject(g_glab_m.glabld,g_glab_m.glab008,"")  THEN            
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glabld
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_m.glab008
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_m.glab008
                  LET g_qryparam.arg3 = g_glab_m.glabld
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab_m.glab008 = g_qryparam.return1   
                  CALL agli190_01_glacl004(g_glab_m.glab008) RETURNING g_glab_m.glab008_desc             
                  DISPLAY g_glab_m.glab008 TO glab008             #顯示到畫面上
                  DISPLAY BY NAME g_glab_m.glab008_desc
                        
               END IF
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glab_m.glabld,g_glab_m.glab008)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glab_m.glab008
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glab_m.glab008 = g_glab_m_t.glab008
                  CALL s_desc_get_account_desc(g_glab_m.glabld,g_glab_m.glab008) RETURNING g_glab_m.glab008_desc
                  DISPLAY BY NAME g_glab_m.glab008_desc
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            CALL agli190_01_glacl004(g_glab_m.glab008) RETURNING g_glab_m.glab008_desc
            DISPLAY BY NAME g_glab_m.glab008_desc
            #160509-00004#3--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab008
            #add-point:BEFORE FIELD glab008 name="input.b.glab008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab008
            #add-point:ON CHANGE glab008 name="input.g.glab008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab014
            
            #add-point:AFTER FIELD glab014 name="input.a.glab014"
            #160509-00004#78--add--str--lujh
            IF NOT cl_null(g_glab_m.glab014) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glab_m.glab014
               #161021-00037#1 --s add 
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #161021-00037#1 --e add 
               #160318-00025#7--add--end
               #呼叫檢查存在並帶值的library
               #IF cl_chk_exist("v_ooef001") THEN    #161021-00037#1 mark
               IF cl_chk_exist("v_ooef001_13") THEN  #161021-00037#1 add
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_glab_m.glab014 = g_glab_m_t.glab014
                  CALL s_desc_get_department_desc(g_glab_m.glab014) RETURNING g_glab_m.glab014_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_glab_m.glab014) RETURNING g_glab_m.glab014_desc
            DISPLAY g_glab_m.glab014_desc TO  glab014_desc
            CALL agli190_01_get_comp(g_glab_m.glab014) RETURNING l_comp
            #160509-00004#78--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab014
            #add-point:BEFORE FIELD glab014 name="input.b.glab014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab014
            #add-point:ON CHANGE glab014 name="input.g.glab014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab015
            
            #add-point:AFTER FIELD glab015 name="input.a.glab015"
            #160509-00004#78--add--str--lujh
            IF NOT cl_null(g_glab_m.glab015) THEN
               CALL s_fin_account_center_with_ld_chk(g_glab_m.glab014,g_glab_m.glab015,g_user,'8','N','',g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glab_m.glab015
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  LET g_glab_m.glab015 = g_glab_m_t.glab015
                  CALL s_desc_get_ld_desc(g_glab_m.glab015) RETURNING g_glab_m.glab015_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_ld_desc(g_glab_m.glab015) RETURNING g_glab_m.glab015_desc
            DISPLAY g_glab_m.glab015_desc TO glab015_desc
            #160509-00004#78--add--end--lujh
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab015
            #add-point:BEFORE FIELD glab015 name="input.b.glab015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab015
            #add-point:ON CHANGE glab015 name="input.g.glab015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab016
            
            #add-point:AFTER FIELD glab016 name="input.a.glab016"
            #160509-00004#91--add--str--lujh
            IF NOT cl_null(g_glab_m.glab016) THEN                    
               IF s_aglt310_getlike_lc_subject(g_glab_m.glab015,g_glab_m.glab016,"")  THEN     
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glab015   
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_m.glab016
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_m.glab016
                  LET g_qryparam.arg3 = g_glab_m.glab015   
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab_m.glab016 = g_qryparam.return1   
                  CALL agli190_01_glacl004(g_glab_m.glab016) RETURNING g_glab_m.glab016_desc             
                  DISPLAY g_glab_m.glab016 TO glab016             #顯示到畫面上
                  DISPLAY BY NAME g_glab_m.glab016_desc
                        
               END IF
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glab_m.glab015,g_glab_m.glab016)   
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glab_m.glab016
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glab_m.glab016 = g_glab_m_t.glab016
                  CALL s_desc_get_account_desc(g_glab_m.glab015,g_glab_m.glab016) RETURNING g_glab_m.glab016_desc  #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh
                  DISPLAY BY NAME g_glab_m.glab016_desc
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            CALL agli190_01_glacl004(g_glab_m.glab016) RETURNING g_glab_m.glab016_desc
            DISPLAY BY NAME g_glab_m.glab016_desc
            #160509-00004#91--add--end--lujh

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab016
            #add-point:BEFORE FIELD glab016 name="input.b.glab016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab016
            #add-point:ON CHANGE glab016 name="input.g.glab016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab009
            
            #add-point:AFTER FIELD glab009 name="input.a.glab009"
            #160509-00004#3--add--str--lujh
            IF NOT cl_null(g_glab_m.glab009) THEN                    
               IF s_aglt310_getlike_lc_subject(g_glab_m.glab015,g_glab_m.glab009,"")  THEN     #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh     
                  
                  SELECT glaa004 INTO l_glaa004
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_glab_m.glab015   #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh
                  
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = 'FALSE'
                  LET g_qryparam.default1 = g_glab_m.glab009
                                
                  LET g_qryparam.arg1 = l_glaa004
                  LET g_qryparam.arg2 = g_glab_m.glab009
                  LET g_qryparam.arg3 = g_glab_m.glab015   #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh
                  LET g_qryparam.arg4 = " 1"
                  CALL q_glac002_6()
                  LET  g_glab_m.glab009 = g_qryparam.return1   
                  CALL agli190_01_glacl004(g_glab_m.glab009) RETURNING g_glab_m.glab009_desc             
                  DISPLAY g_glab_m.glab009 TO glab009             #顯示到畫面上
                  DISPLAY BY NAME g_glab_m.glab009_desc
                        
               END IF
               #科目存在性，有效性，非统治科目，账户科目属性检查
               CALL s_voucher_glaq002_chk(g_glab_m.glab015,g_glab_m.glab009)   #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glab_m.glab009
                  LET g_errparam.replace[1] = 'agli030'
                  LET g_errparam.replace[2] = cl_get_progname('agli030',g_lang,"2")
                  LET g_errparam.exeprog = 'agli030'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glab_m.glab009 = g_glab_m_t.glab009
                  CALL s_desc_get_account_desc(g_glab_m.glab015,g_glab_m.glab009) RETURNING g_glab_m.glab009_desc  #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh
                  DISPLAY BY NAME g_glab_m.glab009_desc
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            CALL agli190_01_glacl004(g_glab_m.glab009) RETURNING g_glab_m.glab009_desc
            DISPLAY BY NAME g_glab_m.glab009_desc
            #160509-00004#3--add--end--lujh

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab009
            #add-point:BEFORE FIELD glab009 name="input.b.glab009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab009
            #add-point:ON CHANGE glab009 name="input.g.glab009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab011
            #add-point:BEFORE FIELD glab011 name="input.b.glab011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab011
            
            #add-point:AFTER FIELD glab011 name="input.a.glab011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab011
            #add-point:ON CHANGE glab011 name="input.g.glab011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab002
            #add-point:BEFORE FIELD glab002 name="input.b.glab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab002
            
            #add-point:AFTER FIELD glab002 name="input.a.glab002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glab_m.glabld) AND NOT cl_null(g_glab_m.glab001) AND NOT cl_null(g_glab_m.glab002) AND NOT cl_null(g_glab_m.glab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glab_m.glabld != g_glabld_t  OR g_glab_m.glab001 != g_glab001_t  OR g_glab_m.glab002 != g_glab002_t  OR g_glab_m.glab003 != g_glab003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glab_m.glabld ||"' AND "|| "glab001 = '"||g_glab_m.glab001 ||"' AND "|| "glab002 = '"||g_glab_m.glab002 ||"' AND "|| "glab003 = '"||g_glab_m.glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab002
            #add-point:ON CHANGE glab002 name="input.g.glab002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glab001
            #add-point:BEFORE FIELD glab001 name="input.b.glab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glab001
            
            #add-point:AFTER FIELD glab001 name="input.a.glab001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glab_m.glabld) AND NOT cl_null(g_glab_m.glab001) AND NOT cl_null(g_glab_m.glab002) AND NOT cl_null(g_glab_m.glab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glab_m.glabld != g_glabld_t  OR g_glab_m.glab001 != g_glab001_t  OR g_glab_m.glab002 != g_glab002_t  OR g_glab_m.glab003 != g_glab003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glab_m.glabld ||"' AND "|| "glab001 = '"||g_glab_m.glab001 ||"' AND "|| "glab002 = '"||g_glab_m.glab002 ||"' AND "|| "glab003 = '"||g_glab_m.glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glab001
            #add-point:ON CHANGE glab001 name="input.g.glab001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glabld
            #add-point:BEFORE FIELD glabld name="input.b.glabld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glabld
            
            #add-point:AFTER FIELD glabld name="input.a.glabld"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_glab_m.glabld) AND NOT cl_null(g_glab_m.glab001) AND NOT cl_null(g_glab_m.glab002) AND NOT cl_null(g_glab_m.glab003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_glab_m.glabld != g_glabld_t  OR g_glab_m.glab001 != g_glab001_t  OR g_glab_m.glab002 != g_glab002_t  OR g_glab_m.glab003 != g_glab003_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM glab_t WHERE "||"glabent = '" ||g_enterprise|| "' AND "||"glabld = '"||g_glab_m.glabld ||"' AND "|| "glab001 = '"||g_glab_m.glab001 ||"' AND "|| "glab002 = '"||g_glab_m.glab002 ||"' AND "|| "glab003 = '"||g_glab_m.glab003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glabld
            #add-point:ON CHANGE glabld name="input.g.glabld"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glab003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab003
            #add-point:ON ACTION controlp INFIELD glab003 name="input.c.glab003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glab005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab005
            #add-point:ON ACTION controlp INFIELD glab005 name="input.c.glab005"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab005             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glab004,"' AND glac003 != '1' ",
                                   #151117-00009#1--add--str--
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glab_m.glabld,"'",
                                   "                    AND gladstus='Y' )"
                                   #151117-00009#1--add--end

            #給予arg

           #CALL q_glac002_4()                                #呼叫開窗
            CALL aglt310_04()

            LET g_glab_m.glab005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli190_01_glacl004(g_glab_m.glab005) RETURNING g_glab_m.glab005_desc

            DISPLAY g_glab_m.glab005 TO glab005              #顯示到畫面上
            DISPLAY BY NAME g_glab_m.glab005_desc
            NEXT FIELD glab005                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.glab006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab006
            #add-point:ON ACTION controlp INFIELD glab006 name="input.c.glab006"
#此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab006             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glab004,"' AND glac003 != '1' ",
                                   #151117-00009#1--add--str--
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glab_m.glabld,"'",
                                   "                    AND gladstus='Y' )"
                                   #151117-00009#1--add--end

            #給予arg

           #CALL q_glac002_4()                                #呼叫開窗
            CALL aglt310_04()

            LET g_glab_m.glab006 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli190_01_glacl004(g_glab_m.glab006) RETURNING g_glab_m.glab006_desc
            

            DISPLAY g_glab_m.glab006 TO glab006              #顯示到畫面上
            DISPLAY BY NAME g_glab_m.glab006_desc
            NEXT FIELD glab006                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.glab007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab007
            #add-point:ON ACTION controlp INFIELD glab007 name="input.c.glab007"
#此段落由子樣板a07產生            
            #開窗i段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab007             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glab004,"' AND glac003 != '1' ",
                                   #151117-00009#1--add--str--
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glab_m.glabld,"'",
                                   "                    AND gladstus='Y' )"
                                   #151117-00009#1--add--end

            #給予arg

           #CALL q_glac002_4()                                #呼叫開窗
            CALL aglt310_04()

            LET g_glab_m.glab007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli190_01_glacl004(g_glab_m.glab007) RETURNING g_glab_m.glab007_desc
            DISPLAY BY NAME g_glab_m.glab007_desc

            DISPLAY g_glab_m.glab007 TO glab007              #顯示到畫面上

            NEXT FIELD glab007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glab008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab008
            #add-point:ON ACTION controlp INFIELD glab008 name="input.c.glab008"
            #160509-00004#3--add--str--lujh
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab008             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glab004,"' AND glac003 != '1' ",
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glab_m.glabld,"'",
                                   "                    AND gladstus='Y' )"

            #給予arg
            CALL aglt310_04()

            LET g_glab_m.glab008 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli190_01_glacl004(g_glab_m.glab008) RETURNING g_glab_m.glab008_desc
            DISPLAY BY NAME g_glab_m.glab008_desc

            DISPLAY g_glab_m.glab008 TO glab008              #顯示到畫面上

            NEXT FIELD glab008                          #返回原欄位
            #160509-00004#3--add--end--lujh


            #END add-point
 
 
         #Ctrlp:input.c.glab014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab014
            #add-point:ON ACTION controlp INFIELD glab014 name="input.c.glab014"
            #160509-00004#78--add--str--lujh
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            #160509-00004#2--add--str--lujh
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_glab_m.glab014             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s
            LET g_qryparam.where = " ooef201 = 'Y' "   #161021-00037#1 add

 
            CALL q_ooef001()                                #呼叫開窗
 
            LET g_glab_m.glab014 = g_qryparam.return1              

            DISPLAY g_glab_m.glab014 TO glab014              #
            CALL s_desc_get_department_desc(g_glab_m.glab014) RETURNING g_glab_m.glab014_desc
            DISPLAY g_glab_m.glab014_desc TO glab014_desc
            CALL agli190_01_get_comp(g_glab_m.glab014) RETURNING l_comp
            NEXT FIELD glab014                          #返回原欄位
            #160509-00004#78--add--end--lujh
            #END add-point
 
 
         #Ctrlp:input.c.glab015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab015
            #add-point:ON ACTION controlp INFIELD glab015 name="input.c.glab015"
            #160509-00004#78--add--str--lujh
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab015             #給予default值
            
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp = '",l_comp,"'"

            #給予arg

            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept

            CALL q_authorised_ld()                                #呼叫開窗

            LET g_glab_m.glab015 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glab_m.glab015 TO glab015              #顯示到畫面上
            CALL s_desc_get_ld_desc(g_glab_m.glab015) RETURNING g_glab_m.glab015_desc
            DISPLAY g_glab_m.glab015_desc TO glab015_desc
            NEXT FIELD glab015                          #返回原欄位
            #160509-00004#78--add--end--lujh
            #END add-point
 
 
         #Ctrlp:input.c.glab016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab016
            #add-point:ON ACTION controlp INFIELD glab016 name="input.c.glab016"
            #160509-00004#91--add--str--lujh
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab016             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glab004,"' AND glac003 != '1' ",
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glab_m.glab015,"'",  #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh  
                                   "                    AND gladstus='Y' )"

            #給予arg
            CALL aglt310_04()

            LET g_glab_m.glab016 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli190_01_glacl004(g_glab_m.glab016) RETURNING g_glab_m.glab016_desc
            DISPLAY BY NAME g_glab_m.glab016_desc

            DISPLAY g_glab_m.glab016 TO glab016              #顯示到畫面上

            NEXT FIELD glab016                          #返回原欄位
            #160509-00004#91--add--end--lujh
            #END add-point
 
 
         #Ctrlp:input.c.glab009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab009
            #add-point:ON ACTION controlp INFIELD glab009 name="input.c.glab009"
            #160509-00004#3--add--str--lujh
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glab_m.glab009             #給予default值
            LET g_qryparam.where = " glac001 = '",g_glab004,"' AND glac003 != '1' ",
                                   " AND glac006='1' ",
                                   " AND glac002 IN (SELECT glad001 FROM glad_t ",
                                   "                  WHERE gladent=",g_enterprise," AND gladld='",g_glab_m.glab015,"'",  #160509-00004#78 change g_glab_m.glabld to g_glab_m.glab015 lujh  
                                   "                    AND gladstus='Y' )"

            #給予arg
            CALL aglt310_04()

            LET g_glab_m.glab009 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL agli190_01_glacl004(g_glab_m.glab009) RETURNING g_glab_m.glab009_desc
            DISPLAY BY NAME g_glab_m.glab009_desc

            DISPLAY g_glab_m.glab009 TO glab009              #顯示到畫面上

            NEXT FIELD glab009                          #返回原欄位
            #160509-00004#3--add--end--lujh
            #END add-point
 
 
         #Ctrlp:input.c.glab011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab011
            #add-point:ON ACTION controlp INFIELD glab011 name="input.c.glab011"
            
            #END add-point
 
 
         #Ctrlp:input.c.glab002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab002
            #add-point:ON ACTION controlp INFIELD glab002 name="input.c.glab002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glab001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glab001
            #add-point:ON ACTION controlp INFIELD glab001 name="input.c.glab001"
            
            #END add-point
 
 
         #Ctrlp:input.c.glabld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glabld
            #add-point:ON ACTION controlp INFIELD glabld name="input.c.glabld"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            CALL s_transaction_begin()
            UPDATE glab_t SET (glab005,glab006,glab007,glab008,glab009,glab011,    #160509-00004#3 add glab008,glab009 lujh
                               glab014,glab015,glab016)      #160509-00004#78 add lujh   #160509-00004#91 add glab016 lujh
                            = (g_glab_m.glab005,g_glab_m.glab006,g_glab_m.glab007,
                               g_glab_m.glab008,g_glab_m.glab009,g_glab_m.glab011, #160509-00004#3 add g_glab_m.glab008,g_glab_m.glab009 lujh
                               g_glab_m.glab014,g_glab_m.glab015,g_glab_m.glab016)   #160509-00004#78 add lujh  #160509-00004#91 add glab016 lujh
                WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld 
                  AND glab001 = '21'

                  AND glab002 = g_glab_m.glab002

                  AND glab003 = g_glab_m.glab003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "glab_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
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
   CLOSE WINDOW w_agli190_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agli190_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli190_01.other_function" readonly="Y" >}
#欄位帶值
PRIVATE FUNCTION agli190_01_glab_ref()
   DEFINE r_gzcbl004       LIKE gzcbl_t.gzcbl004
   DEFINE r_ooial003       LIKE ooial_t.ooial003
   
   SELECT gzcbl004 INTO r_gzcbl004 FROM gzcbl_t 
    WHERE gzcbl001 = '8310' AND gzcbl002 = g_glab_m.glab002 AND gzcbl003 = g_dlang
    
   SELECT ooial003 INTO r_ooial003 FROM ooial_t 
    WHERE ooialent = g_enterprise AND ooial001 = g_glab_m.glab003
      AND ooial002 = g_dlang
   RETURN r_gzcbl004,r_ooial003
END FUNCTION
#科目編號欄位帶值
PRIVATE FUNCTION agli190_01_glacl004(p_glab005)
DEFINE l_glab004    LIKE glab_t.glab004
DEFINE r_glacl004   LIKE glacl_t.glacl004
DEFINE p_glab005    LIKE glab_t.glab005

   SELECT unique glab004 INTO l_glab004 FROM glab_t WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = '21'
   SELECT glacl004 INTO r_glacl004 FROM glacl_t 
    WHERE glaclent = g_enterprise AND glacl001 = l_glab004 
      AND glacl002 = p_glab005 AND glacl003 = g_dlang
   RETURN r_glacl004
END FUNCTION
#檢查會計科目是否存在及非統計類科目
PRIVATE FUNCTION agli190_01_glab_chk(p_glab005)
   DEFINE p_glab005 LIKE glab_t.glab005
   DEFINE l_glab004    LIKE glab_t.glab004
   DEFINE r_success LIKE type_t.num5

   LET r_success = TRUE
   SELECT unique glab004 INTO l_glab004 FROM glab_t WHERE glabent = g_enterprise AND glabld = g_glab_m.glabld AND glab001 = '21'
   IF NOT cl_null(p_glab005) THEN
      #檢查是否存在
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glab005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glab004||"' AND glac002 = ? ","agl-00141",0 ) THEN
            LET r_success = FALSE
         END IF
      END IF
      IF r_success THEN
         IF NOT ap_chk_isExist(p_glab005,"SELECT COUNT(*) FROM glac_t WHERE glacent = '"
            ||g_enterprise||"' AND glac001 = '"||l_glab004||"' AND glac002 = ? AND glac003 != '1' ","agl-00142",0 ) THEN
            LET r_success = FALSE
         END IF
      END IF
   END IF
   RETURN r_success
END FUNCTION
# 抓取據點法人
PRIVATE FUNCTION agli190_01_get_comp(p_site)
   DEFINE p_site          LIKE ooef_t.ooef001
   DEFINE r_comp          LIKE ooef_t.ooef017
   
   LET r_comp = ''
   
   SELECT ooef017 INTO r_comp 
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_site
   
   RETURN r_comp
END FUNCTION

 
{</section>}
 

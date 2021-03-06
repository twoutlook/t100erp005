#該程式未解開Section, 採用最新樣板產出!
{<section id="apjm200_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-01-09 00:00:00), PR版次:0003(2017-02-10 14:48:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000107
#+ Filename...: apjm200_01
#+ Description: WBS計畫日推算條件
#+ Creator....: 01996(2014-01-09 16:39:34)
#+ Modifier...: 01996 -SD/PR- 08734
 
{</section>}
 
{<section id="apjm200_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161124-00048#14  2016/12/14 By 08734    星号整批调整
#170207-00018#3   2017/02/10 By 08734    ROWNUM整批调整
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
PRIVATE type type_g_pjba_m        RECORD
       pjba005 LIKE pjba_t.pjba005, 
   pjba007 LIKE pjba_t.pjba007, 
   pjba008 LIKE pjba_t.pjba008, 
   pjba008_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_pjba_m_t    type_g_pjba_m
#end add-point
 
DEFINE g_pjba_m        type_g_pjba_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apjm200_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION apjm200_01(--)
   #add-point:input段變數傳入 name="input.get_var"
p_pjba001,p_pjba003
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
   DEFINE p_pjba001       LIKE pjba_t.pjba001
   DEFINE p_pjba003       LIKE pjba_t.pjba003
   #DEFINE l_pjbb   RECORD LIKE pjbb_t.*  #161124-00048#14  2016/12/14 By 08734 mark
   #161124-00048#14  2016/12/14 By 08734 add(S)
   DEFINE l_pjbb RECORD  #專案WBS單身檔
       pjbbent LIKE pjbb_t.pjbbent, #企业编号
       pjbb001 LIKE pjbb_t.pjbb001, #项目编号
       pjbb002 LIKE pjbb_t.pjbb002, #本阶WBS
       pjbb003 LIKE pjbb_t.pjbb003, #上阶WBS
       pjbb004 LIKE pjbb_t.pjbb004, #WBS类型
       pjbb005 LIKE pjbb_t.pjbb005, #计划起始日
       pjbb006 LIKE pjbb_t.pjbb006, #计划截止日
       pjbb007 LIKE pjbb_t.pjbb007, #工期天数
       pjbb008 LIKE pjbb_t.pjbb008, #工期时数
       pjbb009 LIKE pjbb_t.pjbb009, #里程碑
       pjbb010 LIKE pjbb_t.pjbb010, #负责人员
       pjbb011 LIKE pjbb_t.pjbb011, #负责部门
       pjbb012 LIKE pjbb_t.pjbb012, #状态码
       pjbb013 LIKE pjbb_t.pjbb013, #发包总额
       pjbb014 LIKE pjbb_t.pjbb014, #未结案发包总额
       pjbb015 LIKE pjbb_t.pjbb015, #结案发包总额
       pjbb016 LIKE pjbb_t.pjbb016 #发包开账金额
END RECORD
#161124-00048#14  2016/12/14 By 08734 add(E)
   DEFINE l_date          LIKE type_t.dat
   #DEFINE l_pjbc   RECORD LIKE pjbc_t.*  #161124-00048#14  2016/12/14 By 08734 mark
   #161124-00048#14  2016/12/14 By 08734 add(S)
   DEFINE l_pjbc RECORD  #專案成員檔
       pjbcent LIKE pjbc_t.pjbcent, #企业编号
       pjbc001 LIKE pjbc_t.pjbc001, #项目编号
       pjbc002 LIKE pjbc_t.pjbc002, #项目角色
       pjbc003 LIKE pjbc_t.pjbc003, #员工编号
       pjbc004 LIKE pjbc_t.pjbc004, #生效日期
       pjbc005 LIKE pjbc_t.pjbc005, #失效日期
       pjbc006 LIKE pjbc_t.pjbc006 #备注
END RECORD
#161124-00048#14  2016/12/14 By 08734 add(E)
   DEFINE l_work_date_b   LIKE type_t.dat
   DEFINE l_work_date_e   LIKE type_t.dat
   DEFINE l_work_days     LIKE type_t.num5
   DEFINE l_work_hours    LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_para          LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_apjm200_01 WITH FORM cl_ap_formpath("apj","apjm200_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
    CALL cl_set_combo_scc('pjba007','16008')
   LET g_pjba_m.pjba007 = '1'
   SELECT ooef008 INTO g_pjba_m.pjba008 FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = 'ALL'
   CALL apjm200_01_pjba008_desc(g_pjba_m.pjba008)
   #170207-00018#3    2017/02/10   By 08734 mark(S)
   #SELECT pjbb005 INTO g_pjba_m.pjba005 FROM pjbb_t
   # WHERE pjbbent = g_enterprise AND pjbb001 = p_pjba003 AND ROWNUM = 1
   #   ORDER BY pjbb002 
   #170207-00018#3    2017/02/10   By 08734 mark(E)
   #170207-00018#3    2017/02/10   By 08734 add(S)
   SELECT A.pjbb005 INTO g_pjba_m.pjba005 FROM (SELECT pjbb005  FROM pjbb_t
    WHERE pjbbent = g_enterprise AND pjbb001 = p_pjba003
      ORDER BY pjbb002) A
   WHERE ROWNUM = 1
   #170207-00018#3    2017/02/10   By 08734 add(E)
   LET g_pjba_m_t.* = g_pjba_m.*
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_pjba_m.pjba005,g_pjba_m.pjba007,g_pjba_m.pjba008 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba005
            #add-point:BEFORE FIELD pjba005 name="input.b.pjba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba005
            
            #add-point:AFTER FIELD pjba005 name="input.a.pjba005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjba005
            #add-point:ON CHANGE pjba005 name="input.g.pjba005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba007
            #add-point:BEFORE FIELD pjba007 name="input.b.pjba007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba007
            
            #add-point:AFTER FIELD pjba007 name="input.a.pjba007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjba007
            #add-point:ON CHANGE pjba007 name="input.g.pjba007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjba008
            
            #add-point:AFTER FIELD pjba008 name="input.a.pjba008"
            CALL apjm200_01_pjba008_desc(g_pjba_m.pjba008)
            IF NOT cl_null(g_pjba_m.pjba008) THEN
               IF NOT s_aooi070_chk_exist('4',g_pjba_m.pjba008) THEN
                  LET g_pjba_m.pjba008 = g_pjba_m_t.pjba008
                  CALL apjm200_01_pjba008_desc(g_pjba_m.pjba008)
                  NEXT FIELD CURRENT
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjba008
            #add-point:BEFORE FIELD pjba008 name="input.b.pjba008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjba008
            #add-point:ON CHANGE pjba008 name="input.g.pjba008"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.pjba005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba005
            #add-point:ON ACTION controlp INFIELD pjba005 name="input.c.pjba005"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjba007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba007
            #add-point:ON ACTION controlp INFIELD pjba007 name="input.c.pjba007"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjba008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjba008
            #add-point:ON ACTION controlp INFIELD pjba008 name="input.c.pjba008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pjba_m.pjba008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = 4 #

            CALL q_ooal002_0()                                #呼叫開窗

            LET g_pjba_m.pjba008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pjba_m.pjba008 TO pjba008              #顯示到畫面上

            NEXT FIELD pjba008                          #返回原欄位


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
   CLOSE WINDOW w_apjm200_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      LET g_success = TRUE
      #DECLARE sel_pjbb_curs CURSOR FOR  SELECT * FROM pjbb_t WHERE pjbbent = g_enterprise  #161124-00048#14  2016/12/14 By 08734 mark
      DECLARE sel_pjbb_curs CURSOR FOR  SELECT pjbbent,pjbb001,pjbb002,pjbb003,pjbb004,pjbb005,pjbb006,pjbb007,
       pjbb008,pjbb009,pjbb010,pjbb011,pjbb012,pjbb013,pjbb014,pjbb015,pjbb016 FROM pjbb_t WHERE pjbbent = g_enterprise  #161124-00048#14  2016/12/14 By 08734 add
                                    AND pjbb001 = p_pjba003
      FOREACH sel_pjbb_curs INTO l_pjbb.*
         IF SQLCA.SQLCODE THEN
            LET g_success = FALSE
            RETURN g_success
         END IF                                      #計算WBS 日期
         IF NOT cl_null(l_pjbb.pjbb005) AND NOT cl_null(l_pjbb.pjbb006) THEN
            LET l_date = g_pjba_m.pjba005 + (l_pjbb.pjbb006 - l_pjbb.pjbb005)
            

            
            UPDATE pjbb_t SET pjbb005 = g_pjba_m.pjba005,
                              pjbb006 = l_date
                        WHERE pjbbent = g_enterprise
                          AND pjbb001 = p_pjba001
                          AND pjbb002 = l_pjbb.pjbb002
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
               LET g_success = FALSE
               RETURN g_success
            END IF
            IF g_pjba_m.pjba007 MATCHES '[12]' THEN
               IF g_pjba_m.pjba007 = '1' THEN
                  LET l_flag = -1 
               ELSE
                  LET l_flag = 1 
               END IF
               LET l_work_date_b = s_date_get_latest_work_date(g_site,g_pjba_m.pjba008,'2',l_flag,g_pjba_m.pjba005)
               LET l_work_date_e = s_date_get_latest_work_date(g_site,g_pjba_m.pjba008,'2',l_flag,l_date)
               
               CALL cl_get_para(g_enterprise,g_site,'E-COM-0007') RETURNING l_para
               LET l_work_days = l_work_date_e - l_work_date_b
               LET l_work_hours =  l_work_days * l_para 
               UPDATE pjbb_t SET pjbb007 = l_work_days,
                                 pjbb008 = l_work_hours
                        WHERE pjbbent = g_enterprise
                          AND pjbb001 = p_pjba001
                          AND pjbb002 = l_pjbb.pjbb002
               IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                  LET g_success = FALSE
                  RETURN g_success
               END IF
            END IF
         END IF         
      END FOREACH
      
      DECLARE sel_pjbc_curs CURSOR FOR                       #計算成員生效失效日期
        #SELECT * FROM pjbc_t WHERE pjbcent = g_enterprise  #161124-00048#14  2016/12/14 By 08734 mark
        SELECT pjbcent,pjbc001,pjbc002,pjbc003,pjbc004,pjbc005,pjbc006 FROM pjbc_t WHERE pjbcent = g_enterprise  #161124-00048#14  2016/12/14 By 08734 add
           AND pjbc001 = p_pjba003
      FOREACH sel_pjbc_curs INTO l_pjbc.*
         IF SQLCA.SQLCODE THEN
            LET g_success = FALSE
            RETURN g_success
         END IF
         LET l_date = g_pjba_m.pjba005 + (l_pjbc.pjbc005 - l_pjbc.pjbc004)
         UPDATE pjbc_t SET pjbc004 = g_pjba_m.pjba005,
                              pjbc005 = l_date
                        WHERE pjbcent = g_enterprise
                          AND pjbc001 = p_pjba001
                          AND pjbc002 = l_pjbc.pjbc002
                          AND pjbc003 = l_pjbc.pjbc003
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
            LET g_success = FALSE
            RETURN g_success
         END IF
      END FOREACH        
   ELSE
      LET g_success = FALSE
   END IF
   IF g_success THEN
      UPDATE pjba_t SET pjba007 = g_pjba_m.pjba007,
                        pjba008 = g_pjba_m.pjba008
                  WHERE pjbaent = g_enterprise
                    AND pjba001 = p_pjba001
      IF SQLCA.SQLCODE THEN
         LET g_success = FALSE
      END IF
   END IF
   RETURN g_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apjm200_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="apjm200_01.other_function" readonly="Y" >}

PRIVATE FUNCTION apjm200_01_pjba008_desc(p_pjba008)
DEFINE p_pjba008   LIKE pjba_t.pjba008
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_pjba008 
    CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='4' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_pjba_m.pjba008_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_pjba_m.pjba008_desc
END FUNCTION

 
{</section>}
 

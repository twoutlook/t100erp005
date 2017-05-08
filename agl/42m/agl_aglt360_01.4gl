#該程式未解開Section, 採用最新樣板產出!
{<section id="aglt360_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2017-02-14 10:01:46), PR版次:0010(2017-02-09 18:54:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000268
#+ Filename...: aglt360_01
#+ Description: 固定核算項
#+ Creator....: 02114(2013-10-29 17:46:10)
#+ Modifier...: 08729 -SD/PR- 04152
 
{</section>}
 
{<section id="aglt360_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#30  2016/03/28 By Jessy    修正azzi920重複定義之錯誤訊息
#160318-00005#18  2016/03/29 by 07675    將重複內容的錯誤訊息置換為公用錯誤訊息
#160614-00004#1   2016/06/14 By 02599    品类开窗控管只查出层级等于管理层级的品类资料
#160913-00017#3   2016/09/21 By 07900    AGL模组调整交易客商开窗
#160729-00009#1   2016/09/28 By 02599    核算项开窗检核增加agli060相关联判断，当agli060中有维护核算项资料时，
#                                        如果是正向(允许)，核算项只可以抓取agli060中维护的值；如果是反向(拒绝)，核算项不可以抓取agli060中维护的值；
#                                        如果没有维护agli060中的值，就按照原逻辑
#161021-00037#3   2016/10/24 By 06821    組織類型與職能開窗調整
#161221-00054#1   2017/02/09 By Reanna   CALL s_voucher_get_glak_sql()調整傳入參數
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
PRIVATE type type_g_glam_m        RECORD
       glam007 LIKE glam_t.glam007, 
   glam007_desc LIKE type_t.chr80, 
   glam008 LIKE glam_t.glam008, 
   glam008_desc LIKE type_t.chr80, 
   glam009 LIKE glam_t.glam009, 
   glam009_desc LIKE type_t.chr80, 
   glam010 LIKE glam_t.glam010, 
   glam010_desc LIKE type_t.chr80, 
   glam011 LIKE glam_t.glam011, 
   glam011_desc LIKE type_t.chr80, 
   glam012 LIKE glam_t.glam012, 
   glam012_desc LIKE type_t.chr80, 
   glam013 LIKE glam_t.glam013, 
   glam013_desc LIKE type_t.chr80, 
   glam014 LIKE glam_t.glam014, 
   glam014_desc LIKE type_t.chr80, 
   glam051 LIKE glam_t.glam051, 
   glam052 LIKE glam_t.glam052, 
   glam052_desc LIKE type_t.chr80, 
   glam053 LIKE glam_t.glam053, 
   glam053_desc LIKE type_t.chr80, 
   glam015 LIKE glam_t.glam015, 
   glam015_desc LIKE type_t.chr80, 
   glam017 LIKE glam_t.glam017, 
   glam017_desc LIKE type_t.chr80, 
   glam018 LIKE glam_t.glam018, 
   glam018_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glam_m_t       type_g_glam_m
DEFINE g_glalld         LIKE glal_t.glalld   #帳別
DEFINE g_glaldocno      LIKE glal_t.glaldocno #分攤编号
DEFINE g_glaldocdt      LIKE glal_t.glaldocdt #傳票日期
DEFINE g_glam002        LIKE glam_t.glam002  #科目     
DEFINE g_seq            LIKE glam_t.glamseq  #项次
DEFINE g_flag           LIKE type_t.chr5
DEFINE g_glaa001        LIKE glaa_t.glaa001  #幣別  
DEFINE g_glaa002        LIKE glaa_t.glaa002  #匯率參照表號
DEFINE g_glaacomp       LIKE glaa_t.glaacomp
DEFINE g_ooag003        LIKE ooag_t.ooag003  #部門
DEFINE g_ooag004        LIKE ooag_t.ooag004  #營運據點
DEFINE g_ooeg004        LIKE ooeg_t.ooeg004  #責任中心
#end add-point
 
DEFINE g_glam_m        type_g_glam_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglt360_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aglt360_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_flag,p_glalld,p_glaldocno,p_glaldocdt,p_glam002,p_seq,p_str
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
   DEFINE p_flag          LIKE type_t.chr5      #资料状态
   DEFINE p_glalld        LIKE glal_t.glalld    #帳別
   DEFINE p_glaldocno     LIKE glal_t.glaldocno #分攤编号
   DEFINE p_glaldocdt     LIKE glal_t.glaldocdt #傳票日期
   DEFINE p_glam002       LIKE glam_t.glam002   #科目
   DEFINE p_seq           LIKE glam_t.glamseq   #项次
   DEFINE p_str           LIKE type_t.chr20
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_ooaa002       LIKE ooaa_t.ooaa002   #160614-00004#1 add
   DEFINE l_glak_sql      STRING                #160729-00009#1 add
   DEFINE l_glak002       LIKE glak_t.glak002   #160729-00009#1 add
   DEFINE l_cnt           LIKE type_t.num5      #160729-00009#1 add
   DEFINE l_wc            STRING                #161221-00054#1
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aglt360_01 WITH FORM cl_ap_formpath("agl","aglt360_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_glalld = p_glalld   
   LET g_glaldocno = p_glaldocno  
   LET g_glaldocdt = p_glaldocdt    
   LET g_glam002 = p_glam002
   #161221-00054#1 add ------
   LET l_wc = g_glam002
   CALL s_fin_get_wc_str(l_wc) RETURNING l_wc
   #161221-00054#1 add end---
   LET g_seq = p_seq    
   LET g_flag = p_flag
   #初始化
   INITIALIZE g_glam_m.* TO NULL
   INITIALIZE g_glam_m_t.* TO NULL  
   
   ##依据对应的主账套编码，抓取币别，汇率参照编号
   SELECT glaa001,glaa002,glaacomp INTO g_glaa001,g_glaa002,g_glaacomp
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glalld 
      
   #依據登入用戶抓取所在部門
   SELECT ooag003 INTO g_ooag003 FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_user
      
   #抓取責任中心
   SELECT ooeg004 INTO g_ooeg004 FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = g_ooag003
        
#   CALL cl_set_combo_scc('glam051','6013') #160729-00009#1 mark
   #品类管理层级aoos010
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_ooaa002 #160614-00004#1 add
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glam_m.glam007,g_glam_m.glam008,g_glam_m.glam009,g_glam_m.glam010,g_glam_m.glam011, 
          g_glam_m.glam012,g_glam_m.glam013,g_glam_m.glam014,g_glam_m.glam051,g_glam_m.glam052,g_glam_m.glam053, 
          g_glam_m.glam015,g_glam_m.glam017,g_glam_m.glam018 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #抓取原值顯示
            IF p_flag = 'a' THEN 
               LET g_glam_m.glam007 = g_site
               DISPLAY g_glam_m.glam007 TO glam007
            ELSE
               IF p_str = 'glam002' THEN 
                  SELECT glam007,glam008,glam009,glam010,glam011,glam012,
                         glam013,glam014,glam015,glam017,glam018,glam051,glam052,glam053
                    INTO g_glam_m.glam007,g_glam_m.glam008,g_glam_m.glam009,g_glam_m.glam010,g_glam_m.glam011,g_glam_m.glam012,
                         g_glam_m.glam013,g_glam_m.glam014,g_glam_m.glam015,g_glam_m.glam017,g_glam_m.glam018,g_glam_m.glam051,
                         g_glam_m.glam052,g_glam_m.glam053
                    FROM glam_t
                   WHERE glament = g_enterprise
                     AND glamld = p_glalld
                     AND glamdocno = p_glaldocno
                     AND glamseq = p_seq  
               END IF
               IF p_str = 'glam005' THEN 
                  SELECT glam019,glam020,glam021,glam022,glam023,glam024,
                         glam025,glam026,glam027,glam029,glam030,glam054,glam055,glam056
                    INTO g_glam_m.glam007,g_glam_m.glam008,g_glam_m.glam009,g_glam_m.glam010,g_glam_m.glam011,g_glam_m.glam012,
                         g_glam_m.glam013,g_glam_m.glam014,g_glam_m.glam015,g_glam_m.glam017,g_glam_m.glam018,g_glam_m.glam051,
                         g_glam_m.glam052,g_glam_m.glam053
                    FROM glam_t
                   WHERE glament = g_enterprise
                     AND glamld = p_glalld
                     AND glamdocno = p_glaldocno
                     AND glamseq = p_seq  
               END IF
               IF p_str = 'glam006' THEN 
                  SELECT glam031,glam032,glam033,glam034,glam035,glam036,
                         glam037,glam038,glam039,glam041,glam042,glam057,glam058,glam059
                    INTO g_glam_m.glam007,g_glam_m.glam008,g_glam_m.glam009,g_glam_m.glam010,g_glam_m.glam011,g_glam_m.glam012,
                         g_glam_m.glam013,g_glam_m.glam014,g_glam_m.glam015,g_glam_m.glam017,g_glam_m.glam018,g_glam_m.glam051,
                         g_glam_m.glam052,g_glam_m.glam053            
                    FROM glam_t
                   WHERE glament = g_enterprise
                     AND glamld = p_glalld
                     AND glamdocno = p_glaldocno
                     AND glamseq = p_seq  
               END IF  
               IF p_str = 'glan001' THEN 
                  SELECT glan003,glan004,glan005,glan006,glan007,glan008,
                         glan009,glan010,glan011,glan013,glan014,glan051,glan052,glan053
                    INTO g_glam_m.glam007,g_glam_m.glam008,g_glam_m.glam009,g_glam_m.glam010,g_glam_m.glam011,g_glam_m.glam012,
                         g_glam_m.glam013,g_glam_m.glam014,g_glam_m.glam015,g_glam_m.glam017,g_glam_m.glam018,g_glam_m.glam051,
                         g_glam_m.glam052,g_glam_m.glam053
                    FROM glan_t
                   WHERE glanent = g_enterprise
                     AND glanld = p_glalld
                     AND glandocno = p_glaldocno
                     AND glanseq = p_seq  
               END IF               
            END IF  
            #營運據點
            IF cl_null(g_glam_m.glam007) THEN 
               LET g_glam_m.glam007 = g_glaacomp
               DISPLAY g_glam_m.glam007 TO glam007
            END IF 
            #部門
            IF cl_null(g_glam_m.glam008) THEN 
               LET g_glam_m.glam008 = g_ooag003
               DISPLAY g_glam_m.glam008 TO glam008
            END IF
            #成本/利潤中心
            IF cl_null(g_glam_m.glam009) THEN 
#               LET g_glam_m.glam009 = g_ooeg004
               IF NOT cl_null(g_glam_m.glam008) THEN
                  SELECT ooeg004 INTO g_glam_m.glam009 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_glam_m.glam008
               ELSE
                  SELECT ooeg004 INTO g_glam_m.glam009 FROM ooeg_t WHERE ooegent = g_enterprise AND ooeg001 = g_ooag003
               END IF
               DISPLAY g_glam_m.glam009 TO glam009
            END IF 
            #人員
            IF cl_null(g_glam_m.glam015) THEN 
               LET g_glam_m.glam015 = g_user
               DISPLAY g_glam_m.glam015 TO glam015
            END IF 
            CALL aglt360_01_visible()
            #160729-00009#1--add--str--
            #营运据点
            IF NOT cl_null(g_glam_m.glam007) THEN
               LET l_glak002=''
               SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                WHERE glakent=g_enterprise AND glakld=g_glalld
                  AND glak001='01' AND glak003=g_glam002
               IF NOT cl_null(l_glak002) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM glak_t 
                   WHERE glakent=g_enterprise AND glakld=g_glalld
                     AND glak001='01' AND glak003=g_glam002
                     AND glak004=g_glam_m.glam007
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  #正向(允许)
                  IF l_glak002='1' THEN
                     IF l_cnt = 0 THEN LET g_glam_m.glam007 = '' END IF
                  ELSE
                  #反向(拒绝)
                     IF l_cnt > 0 THEN LET g_glam_m.glam007 = '' END IF
                  END IF
               END IF
            END IF
            #部门
            IF NOT cl_null(g_glam_m.glam008) THEN
               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt FROM ooeg_t 
                WHERE ooegent = g_enterprise AND ooeg001 = g_glam_m.glam008
                  AND ooeg006<=g_glaldocdt 
                  AND (ooeg007 IS NULL OR ooeg007 > g_glaldocdt)
                  AND ooegstus='Y'
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt > 0 THEN
                  LET l_glak002=''
                  SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                   WHERE glakent=g_enterprise AND glakld=g_glalld
                     AND glak001='02' AND glak003=g_glam002
                  IF NOT cl_null(l_glak002) THEN
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt FROM glak_t 
                      WHERE glakent=g_enterprise AND glakld=g_glalld
                        AND glak001='02' AND glak003=g_glam002
                        AND glak004=g_glam_m.glam008
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                     #正向(允许)
                     IF l_glak002='1' THEN
                        IF l_cnt = 0 THEN LET g_glam_m.glam008 = '' END IF
                     ELSE
                     #反向(拒绝)
                        IF l_cnt > 0 THEN LET g_glam_m.glam008 = '' END IF
                     END IF
                  END IF
               ELSE
                  LET g_glam_m.glam008 = ''
               END IF
            END IF
            #利润/成本中心
            IF NOT cl_null(g_glam_m.glam009) THEN
               LET l_cnt = 0
               SELECT COUNT(1) INTO l_cnt FROM ooeg_t 
                WHERE ooegent = g_enterprise AND ooeg001 = g_glam_m.glam009
                  AND ooeg006<=g_glaldocdt 
                  AND (ooeg007 IS NULL OR ooeg007 > g_glaldocdt)
                  AND ooegstus='Y' AND ooeg003 IN ('1','2','3')
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt > 0 THEN
                  LET l_glak002=''
                  SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                   WHERE glakent=g_enterprise AND glakld=g_glalld
                     AND glak001='03' AND glak003=g_glam002
                  IF NOT cl_null(l_glak002) THEN
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt FROM glak_t 
                      WHERE glakent=g_enterprise AND glakld=g_glalld
                        AND glak001='03' AND glak003=g_glam002
                        AND glak004=g_glam_m.glam009
                     IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                     #正向(允许)
                     IF l_glak002='1' THEN
                        IF l_cnt = 0 THEN LET g_glam_m.glam009 = '' END IF
                     ELSE
                     #反向(拒绝)
                        IF l_cnt > 0 THEN LET g_glam_m.glam009 = '' END IF
                     END IF
                  END IF
               ELSE
                  LET g_glam_m.glam009 = ''
               END IF
            END IF  
            #人员
            IF NOT cl_null(g_glam_m.glam015) THEN
               LET l_glak002=''
               SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
                WHERE glakent=g_enterprise AND glakld=g_glalld
                  AND glak001='12' AND glak003=g_glam002
               IF NOT cl_null(l_glak002) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM glak_t 
                   WHERE glakent=g_enterprise AND glakld=g_glalld
                     AND glak001='12' AND glak003=g_glam002
                     AND glak004=g_glam_m.glam015
                  IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
                  #正向(允许)
                  IF l_glak002='1' THEN
                     IF l_cnt = 0 THEN LET g_glam_m.glam015 = '' END IF
                  ELSE
                  #反向(拒绝)
                     IF l_cnt > 0 THEN LET g_glam_m.glam015 = '' END IF
                  END IF
               END IF
            END IF
            #160729-00009#1--add--end
            LET g_glam_m_t.* = g_glam_m.*                
            CALL aglt360_01_ref_show()            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam007
            
            #add-point:AFTER FIELD glam007 name="input.a.glam007"
            IF NOT cl_null(g_glam_m.glam007) THEN
               CALL s_voucher_glaq017_chk(g_glam_m.glam007)
               IF NOT cl_null(g_errno) THEN
                  DISPLAY '' TO glam007
                  DISPLAY '' TO glam007_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam007
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'aooi100'
                  LET g_errparam.replace[2] = cl_get_progname('aooi100',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi100'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam007 = g_glam_m_t.glam007
#                  CALL aglt360_01_ref_show()  #160729-00009#1 mark
                  CALL s_desc_get_department_desc(g_glam_m.glam007) RETURNING g_glam_m.glam007_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam007_desc #160729-00009#1 add
                  NEXT FIELD glam007
               #161021-00037#3 --s add
               ELSE
                  INITIALIZE g_chkparam.* TO NULL 
                  LET g_chkparam.arg1 = g_glam_m.glam007
                  LET g_errshow = TRUE 
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooef001_13") THEN  
                     LET g_glam_m.glam007 = g_glam_m_t.glam007
                     CALL s_desc_get_department_desc(g_glam_m.glam007) RETURNING g_glam_m.glam007_desc 
                     DISPLAY BY NAME g_glam_m.glam007_desc
                     NEXT FIELD glam007
                  END IF
               #161021-00037#3 --e add
               END IF
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'01',g_glam002,g_glam_m.glam007) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam007 = g_glam_m_t.glam007
                  CALL s_desc_get_department_desc(g_glam_m.glam007) RETURNING g_glam_m.glam007_desc
                  DISPLAY BY NAME g_glam_m.glam007_desc
                  NEXT FIELD glam007
               END IF
               #160729-00009#1--add--end
            END IF 

#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_department_desc(g_glam_m.glam007) RETURNING g_glam_m.glam007_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam007_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam007
            #add-point:BEFORE FIELD glam007 name="input.b.glam007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam007
            #add-point:ON CHANGE glam007 name="input.g.glam007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam008
            
            #add-point:AFTER FIELD glam008 name="input.a.glam008"
            IF NOT cl_null(g_glam_m.glam008) THEN
               CALL s_department_chk(g_glam_m.glam008,p_glaldocdt) RETURNING l_success
               IF NOT l_success THEN
                  DISPLAY '' TO glam008
                  DISPLAY '' TO glam008_desc
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_glam_m.glam008
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()

                  LET g_glam_m.glam008 = g_glam_m_t.glam008
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_department_desc(g_glam_m.glam008) RETURNING g_glam_m.glam008_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam008_desc #160729-00009#1 add
                  NEXT FIELD glam008
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'02',g_glam002,g_glam_m.glam008) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam008 = g_glam_m_t.glam008
                  CALL s_desc_get_department_desc(g_glam_m.glam008) RETURNING g_glam_m.glam008_desc
                  DISPLAY BY NAME g_glam_m.glam008_desc
                  NEXT FIELD glam008
               END IF
               #160729-00009#1--add--end
            END IF 
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_department_desc(g_glam_m.glam008) RETURNING g_glam_m.glam008_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam008_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam008
            #add-point:BEFORE FIELD glam008 name="input.b.glam008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam008
            #add-point:ON CHANGE glam008 name="input.g.glam008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam009
            
            #add-point:AFTER FIELD glam009 name="input.a.glam009"
            IF NOT cl_null(g_glam_m.glam009) THEN
               CALL s_voucher_glaq019_chk(g_glam_m.glam009,p_glaldocdt)
               IF NOT cl_null(g_errno) THEN
                  DISPLAY '' TO glam009
                  DISPLAY '' TO glam009_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam009
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam009 = g_glam_m_t.glam009 
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_department_desc(g_glam_m.glam009) RETURNING g_glam_m.glam009_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam009_desc #160729-00009#1 add
                  NEXT FIELD glam009
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'03',g_glam002,g_glam_m.glam009) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam009 = g_glam_m_t.glam009
                  CALL s_desc_get_department_desc(g_glam_m.glam009) RETURNING g_glam_m.glam009_desc
                  DISPLAY BY NAME g_glam_m.glam009_desc
                  NEXT FIELD glam009
               END IF
               #160729-00009#1--add--end
            END IF 
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_department_desc(g_glam_m.glam009) RETURNING g_glam_m.glam009_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam009_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam009
            #add-point:BEFORE FIELD glam009 name="input.b.glam009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam009
            #add-point:ON CHANGE glam009 name="input.g.glam009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam010
            
            #add-point:AFTER FIELD glam010 name="input.a.glam010"
            IF NOT cl_null(g_glam_m.glam010) THEN
               CALL s_azzi650_chk_exist('287',g_glam_m.glam010) RETURNING l_success
               IF NOT l_success THEN
                  DISPLAY '' TO glam010
                  DISPLAY '' TO glam010_desc
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_glam_m.glam010
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()

                  LET g_glam_m.glam010 = g_glam_m_t.glam010
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_acc_desc('287',g_glam_m.glam010) RETURNING g_glam_m.glam010_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam010_desc #160729-00009#1 add
                  NEXT FIELD glam010
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'04',g_glam002,g_glam_m.glam010) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam010 = g_glam_m_t.glam010
                  CALL s_desc_get_acc_desc('287',g_glam_m.glam010) RETURNING g_glam_m.glam010_desc
                  DISPLAY BY NAME g_glam_m.glam010_desc
                  NEXT FIELD glam010
               END IF
               #160729-00009#1--add--end
            END IF 
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_acc_desc('287',g_glam_m.glam010) RETURNING g_glam_m.glam010_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam010_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam010
            #add-point:BEFORE FIELD glam010 name="input.b.glam010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam010
            #add-point:ON CHANGE glam010 name="input.g.glam010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam011
            
            #add-point:AFTER FIELD glam011 name="input.a.glam011"
            IF NOT cl_null(g_glam_m.glam011) THEN
               CALL s_voucher_glaq021_chk(g_glam_m.glam011) 
               IF NOT cl_null(g_errno) THEN
                  DISPLAY '' TO glam011
                  DISPLAY '' TO glam011_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam011
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam011 = g_glam_m_t.glam011
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam011) RETURNING g_glam_m.glam011_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam011_desc #160729-00009#1 add
                  NEXT FIELD glam011
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'05',g_glam002,g_glam_m.glam011) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam011 = g_glam_m_t.glam011
                  CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam011) RETURNING g_glam_m.glam011_desc
                  DISPLAY BY NAME g_glam_m.glam011_desc
                  NEXT FIELD glam011
               END IF
               #160729-00009#1--add--end
            END IF 
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam011) RETURNING g_glam_m.glam011_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam011_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam011
            #add-point:BEFORE FIELD glam011 name="input.b.glam011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam011
            #add-point:ON CHANGE glam011 name="input.g.glam011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam012
            
            #add-point:AFTER FIELD glam012 name="input.a.glam012"
            IF NOT cl_null(g_glam_m.glam012) THEN
               CALL s_voucher_glaq021_chk(g_glam_m.glam012) 
               IF NOT cl_null(g_errno) THEN
                  DISPLAY '' TO glam012
                  DISPLAY '' TO glam012_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam012
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'apmm100'
                  LET g_errparam.replace[2] = cl_get_progname('apmm100',g_lang,"2")
                  LET g_errparam.exeprog = 'apmm100'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam012 = g_glam_m_t.glam012
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam012) RETURNING g_glam_m.glam012_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam012_desc #160729-00009#1 add
                  NEXT FIELD glam012
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'06',g_glam002,g_glam_m.glam012) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam012 = g_glam_m_t.glam012
                  CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam012) RETURNING g_glam_m.glam012_desc
                  DISPLAY BY NAME g_glam_m.glam012_desc
                  NEXT FIELD glam012
               END IF
               #160729-00009#1--add--end
            END IF 
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam012) RETURNING g_glam_m.glam012_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam012_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam012
            #add-point:BEFORE FIELD glam012 name="input.b.glam012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam012
            #add-point:ON CHANGE glam012 name="input.g.glam012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam013
            
            #add-point:AFTER FIELD glam013 name="input.a.glam013"
            IF NOT cl_null(g_glam_m.glam013) THEN
               CALL s_azzi650_chk_exist('281',g_glam_m.glam013) RETURNING l_success
               IF NOT l_success THEN
                  DISPLAY '' TO glam013
                  DISPLAY '' TO glam013_desc
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_glam_m.glam013
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()

                  LET g_glam_m.glam013 = g_glam_m_t.glam013
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_acc_desc('281',g_glam_m.glam013) RETURNING g_glam_m.glam013_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam013_desc #160729-00009#1 add
                  NEXT FIELD glam013
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'07',g_glam002,g_glam_m.glam013) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam013 = g_glam_m_t.glam013
                  CALL s_desc_get_acc_desc('281',g_glam_m.glam013) RETURNING g_glam_m.glam013_desc
                  DISPLAY BY NAME g_glam_m.glam013_desc
                  NEXT FIELD glam013
               END IF
               #160729-00009#1--add--end
            END IF 
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_acc_desc('281',g_glam_m.glam013) RETURNING g_glam_m.glam013_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam013_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam013
            #add-point:BEFORE FIELD glam013 name="input.b.glam013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam013
            #add-point:ON CHANGE glam013 name="input.g.glam013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam014
            
            #add-point:AFTER FIELD glam014 name="input.a.glam014"
            IF NOT cl_null(g_glam_m.glam014) THEN
               CALL s_voucher_glaq024_chk(g_glam_m.glam014)
               IF NOT cl_null(g_errno) THEN
                  DISPLAY '' TO glam014
                  DISPLAY '' TO glam014_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam014
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'arti202'
                  LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                  LET g_errparam.exeprog = 'arti202'
                  #160321-00016#30 --e add 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam014 = g_glam_m_t.glam014
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_rtaxl003_desc(g_glam_m.glam014) RETURNING g_glam_m.glam014_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam014_desc #160729-00009#1 add
                  NEXT FIELD glam014
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'08',g_glam002,g_glam_m.glam014) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam014 = g_glam_m_t.glam014
                  CALL s_desc_get_rtaxl003_desc(g_glam_m.glam014) RETURNING g_glam_m.glam014_desc
                  DISPLAY BY NAME g_glam_m.glam014_desc
                  NEXT FIELD glam014
               END IF
               #160729-00009#1--add--end
            END IF 
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_rtaxl003_desc(g_glam_m.glam014) RETURNING g_glam_m.glam014_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam014_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam014
            #add-point:BEFORE FIELD glam014 name="input.b.glam014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam014
            #add-point:ON CHANGE glam014 name="input.g.glam014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam051
            #add-point:BEFORE FIELD glam051 name="input.b.glam051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam051
            
            #add-point:AFTER FIELD glam051 name="input.a.glam051"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam051
            #add-point:ON CHANGE glam051 name="input.g.glam051"
            IF NOT cl_null(g_glam_m.glam051) THEN
               CALL s_voucher_glaq051_chk(g_glam_m.glam051) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam051
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam051 = g_glam_m_t.glam051
                  NEXT FIELD glam051  #160729-00009#1 add
               END IF
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'09',g_glam002,g_glam_m.glam051) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam051 = g_glam_m_t.glam051
                  NEXT FIELD glam051
               END IF
               #160729-00009#1--add--end
            END IF
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam052
            
            #add-point:AFTER FIELD glam052 name="input.a.glam052"
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            IF NOT cl_null(g_glam_m.glam052) THEN
               CALL s_voucher_glaq052_chk(g_glam_m.glam052) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam052
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam052 = g_glam_m_t.glam052
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_oojdl003_desc(g_glam_m.glam052) RETURNING g_glam_m.glam052_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam052_desc #160729-00009#1 add
                  NEXT FIELD glam052
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'10',g_glam002,g_glam_m.glam052) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam052 = g_glam_m_t.glam052
                  CALL s_desc_get_oojdl003_desc(g_glam_m.glam052) RETURNING g_glam_m.glam052_desc
                  DISPLAY BY NAME g_glam_m.glam052_desc
                  NEXT FIELD glam052
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL s_desc_get_oojdl003_desc(g_glam_m.glam052) RETURNING g_glam_m.glam052_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam052_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam052
            #add-point:BEFORE FIELD glam052 name="input.b.glam052"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam052
            #add-point:ON CHANGE glam052 name="input.g.glam052"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam053
            
            #add-point:AFTER FIELD glam053 name="input.a.glam053"
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            IF NOT cl_null(g_glam_m.glam053) THEN
               CALL s_voucher_glaq020_chk('2002',g_glam_m.glam053) 
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam053
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam053 = g_glam_m_t.glam053
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_acc_desc('2002',g_glam_m.glam053) RETURNING g_glam_m.glam053_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam053_desc #160729-00009#1 add
                  NEXT FIELD glaq053
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'11',g_glam002,g_glam_m.glam053) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam053 = g_glam_m_t.glam053
                  CALL s_desc_get_acc_desc('2002',g_glam_m.glam053) RETURNING g_glam_m.glam053_desc
                  DISPLAY BY NAME g_glam_m.glam053_desc
                  NEXT FIELD glam053
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL s_desc_get_acc_desc('2002',g_glam_m.glam053) RETURNING g_glam_m.glam053_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam053_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam053
            #add-point:BEFORE FIELD glam053 name="input.b.glam053"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam053
            #add-point:ON CHANGE glam053 name="input.g.glam053"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam015
            
            #add-point:AFTER FIELD glam015 name="input.a.glam015"
            IF NOT cl_null(g_glam_m.glam015) THEN
               CALL s_employee_chk(g_glam_m.glam015) RETURNING l_success
               IF NOT l_success THEN
                  DISPLAY '' TO glam015
                  DISPLAY '' TO glam015_desc
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = g_glam_m.glam015
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()

                  LET g_glam_m.glam015 = g_glam_m_t.glam015
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_person_desc(g_glam_m.glam015) RETURNING g_glam_m.glam015_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam015_desc #160729-00009#1 add
                  NEXT FIELD glam015
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'12',g_glam002,g_glam_m.glam015) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam015 = g_glam_m_t.glam015
                  CALL s_desc_get_person_desc(g_glam_m.glam015) RETURNING g_glam_m.glam015_desc
                  DISPLAY BY NAME g_glam_m.glam015_desc
                  NEXT FIELD glam015
               END IF
               #160729-00009#1--add--end
            END IF
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_person_desc(g_glam_m.glam015) RETURNING g_glam_m.glam015_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam015_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam015
            #add-point:BEFORE FIELD glam015 name="input.b.glam015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam015
            #add-point:ON CHANGE glam015 name="input.g.glam015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam017
            
            #add-point:AFTER FIELD glam017 name="input.a.glam017"
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            IF NOT cl_null(g_glam_m.glam017) THEN
               CALL s_aap_project_chk(g_glam_m.glam017) RETURNING l_success,g_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam017
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'apjm200'
                  LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                  LET g_errparam.exeprog = 'apjm200'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam017 = g_glam_m_t.glam017
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_project_desc(g_glam_m.glam017) RETURNING g_glam_m.glam017_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam017_desc #160729-00009#1 add
                  NEXT FIELD glam017
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'13',g_glam002,g_glam_m.glam017) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam017 = g_glam_m_t.glam017
                  CALL s_desc_get_project_desc(g_glam_m.glam017) RETURNING g_glam_m.glam017_desc
                  DISPLAY BY NAME g_glam_m.glam017_desc
                  NEXT FIELD glam017
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL s_desc_get_project_desc(g_glam_m.glam017) RETURNING g_glam_m.glam017_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam017_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam017
            #add-point:BEFORE FIELD glam017 name="input.b.glam017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam017
            #add-point:ON CHANGE glam017 name="input.g.glam017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glam018
            
            #add-point:AFTER FIELD glam018 name="input.a.glam018"
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            IF NOT cl_null(g_glam_m.glam018) THEN
               CALL s_voucher_glaq028_chk(g_glam_m.glam017,g_glam_m.glam018)
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_glam_m.glam018
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_glam_m.glam018 = g_glam_m_t.glam018
#                  CALL aglt360_01_ref_show() #160729-00009#1 mark
                  CALL s_desc_get_wbs_desc(g_glam_m.glam017,g_glam_m.glam018) RETURNING g_glam_m.glam018_desc #160729-00009#1 add
                  DISPLAY BY NAME g_glam_m.glam018_desc #160729-00009#1 add
                  NEXT FIELD glam018
               END IF 
               #160729-00009#1--add--str--
               #判断agli060是否设置限制核算项资料，如果设置，判断是否满足agli060条件               
               CALL s_voucher_hsx_glak_chk(g_glalld,'14',g_glam002,g_glam_m.glam018) RETURNING l_success
               IF NOT l_success THEN
                  LET g_glam_m.glam018 = g_glam_m_t.glam018
                  CALL s_desc_get_wbs_desc(g_glam_m.glam017,g_glam_m.glam018) RETURNING g_glam_m.glam018_desc
                  DISPLAY BY NAME g_glam_m.glam018_desc
                  NEXT FIELD glam017
               END IF
               #160729-00009#1--add--end
            END IF 
            CALL s_desc_get_wbs_desc(g_glam_m.glam017,g_glam_m.glam018) RETURNING g_glam_m.glam018_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam018_desc #160729-00009#1 add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glam018
            #add-point:BEFORE FIELD glam018 name="input.b.glam018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glam018
            #add-point:ON CHANGE glam018 name="input.g.glam018"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glam007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam007
            #add-point:ON ACTION controlp INFIELD glam007 name="input.c.glam007"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam007             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的WBS限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'01',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'01',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = " ooefstus='Y' AND ",l_glak_sql 
            #160729-00009#1--add--end
            LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y' " #161021-00037#3 add
            
            CALL q_ooef001()                                #呼叫開窗

            LET g_glam_m.glam007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            
            DISPLAY g_glam_m.glam007 TO glam007              #顯示到畫面上
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_department_desc(g_glam_m.glam007) RETURNING g_glam_m.glam007_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam007_desc #160729-00009#1 add
            NEXT FIELD glam007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam008
            #add-point:ON ACTION controlp INFIELD glam008 name="input.c.glam008"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam008             #給予default值

            #給予arg
#            LET g_qryparam.where = "  ooeg006 <= '",p_glaldocdt,"'",
#                                   "  AND (ooeg007 IS NULL OR ooeg007 >= '",p_glaldocdt,"') "
            LET g_qryparam.arg1=p_glaldocdt
            #160729-00009#1--add--str--
            #agli060设置的部门限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'02',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'02',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_ooeg001_4()                                #呼叫開窗

            LET g_glam_m.glam008 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glam_m.glam008 TO glam008              #顯示到畫面上
            LET g_qryparam.where = NULL
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_department_desc(g_glam_m.glam008) RETURNING g_glam_m.glam008_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam008_desc #160729-00009#1 add
            NEXT FIELD glam008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam009
            #add-point:ON ACTION controlp INFIELD glam009 name="input.c.glam009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam009             #給予default值

            #給予arg
            LET g_qryparam.arg1=p_glaldocdt
#            CALL q_ooeg001_5()                                 #呼叫開窗 
            #160729-00009#1--add--str--
            #agli060设置的部门限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'03',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'03',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = "  ooeg003 IN ('1','2','3') AND ",l_glak_sql 
            CALL q_ooeg001_4() 
            #160729-00009#1--add--end

            LET g_glam_m.glam009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glam_m.glam009 TO glam009              #顯示到畫面上
            LET g_qryparam.where = NULL
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_department_desc(g_glam_m.glam009) RETURNING g_glam_m.glam009_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam009_desc #160729-00009#1 add
            NEXT FIELD glam009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam010
            #add-point:ON ACTION controlp INFIELD glam010 name="input.c.glam010"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam010             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的区域限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'04',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'04',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end

            CALL q_oocq002_287()                                #呼叫開窗

            LET g_glam_m.glam010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glam_m.glam010 TO glam010              #顯示到畫面上
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_acc_desc('287',g_glam_m.glam010) RETURNING g_glam_m.glam010_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam010_desc #160729-00009#1 add
            NEXT FIELD glam010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam011
            #add-point:ON ACTION controlp INFIELD glam011 name="input.c.glam011"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam011             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的区域限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'05',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'05',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end

            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗

            LET g_glam_m.glam011 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glam_m.glam011 TO glam011              #顯示到畫面上
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam011) RETURNING g_glam_m.glam011_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam011_desc #160729-00009#1 add
            NEXT FIELD glam011                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam012
            #add-point:ON ACTION controlp INFIELD glam012 name="input.c.glam012"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam012             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的区域限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'06',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'06',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end

            CALL q_pmaa001_25()      #160913-00017#3  add
            #CALL q_pmaa001()        #160913-00017#3  mark               #呼叫開窗

            LET g_glam_m.glam012 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glam_m.glam012 TO glam012              #顯示到畫面上
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_trading_partner_abbr_desc(g_glam_m.glam012) RETURNING g_glam_m.glam012_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam012_desc #160729-00009#1 add
            NEXT FIELD glam012                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam013
            #add-point:ON ACTION controlp INFIELD glam013 name="input.c.glam013"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam013             #給予default值

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的区域限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'07',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'07',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end

            CALL q_oocq002_281()                                #呼叫開窗

            LET g_glam_m.glam013 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glam_m.glam013 TO glam013              #顯示到畫面上
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_acc_desc('281',g_glam_m.glam013) RETURNING g_glam_m.glam013_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam013_desc #160729-00009#1 add
            NEXT FIELD glam013                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam014
            #add-point:ON ACTION controlp INFIELD glam014 name="input.c.glam014"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam014             #給予default值
            LET g_qryparam.where = " rtax004='",l_ooaa002,"'" #160614-00004#1 add
            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的产品类别限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'08',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'08',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql
            CALL q_rtax001_1()
            #160729-00009#1--add--end

#            CALL q_rtax001()                                #呼叫開窗 #160729-00009#1 mark

            LET g_glam_m.glam014 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_glam_m.glam014 TO glam014              #顯示到畫面上
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_rtaxl003_desc(g_glam_m.glam014) RETURNING g_glam_m.glam014_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam014_desc #160729-00009#1 add
            NEXT FIELD glam014                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam051
            #add-point:ON ACTION controlp INFIELD glam051 name="input.c.glam051"
            
            #END add-point
 
 
         #Ctrlp:input.c.glam052
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam052
            #add-point:ON ACTION controlp INFIELD glam052 name="input.c.glam052"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam052             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #
            #160729-00009#1--add--str--
            #agli060设置的产品类别限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'10',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'10',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = " oojdstus='Y' AND ",l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_oojd001_2()                                #呼叫開窗

            LET g_glam_m.glam052 = g_qryparam.return1              

            DISPLAY g_glam_m.glam052 TO glam052              #
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_oojdl003_desc(g_glam_m.glam052) RETURNING g_glam_m.glam052_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam052_desc #160729-00009#1 add
            NEXT FIELD glam052                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam053
            #add-point:ON ACTION controlp INFIELD glam053 name="input.c.glam053"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam053             #給予default值
            LET g_qryparam.default2 = "" #g_glam_m.oocq002 #應用分類碼
            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的产品类别限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'11',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'11',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_oocq002_2002()                                #呼叫開窗

            LET g_glam_m.glam053 = g_qryparam.return1              
            #LET g_glam_m.oocq002 = g_qryparam.return2 
            DISPLAY g_glam_m.glam053 TO glam053              #
            #DISPLAY g_glam_m.oocq002 TO oocq002 #應用分類碼
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_acc_desc('2002',g_glam_m.glam053) RETURNING g_glam_m.glam053_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam053_desc #160729-00009#1 add
            NEXT FIELD glam053                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam015
            #add-point:ON ACTION controlp INFIELD glam015 name="input.c.glam015"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam015             #給予default值
            LET g_qryparam.default2 = "" #g_glam_m.oofa011 #全名

            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的产品类别限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'12',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'12',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end

            CALL q_ooag001_8()                                #呼叫開窗

            LET g_glam_m.glam015 = g_qryparam.return1              #將開窗取得的值回傳到變數
            #LET g_glam_m.oofa011 = g_qryparam.return2 #全名

            DISPLAY g_glam_m.glam015 TO glam015              #顯示到畫面上
            #DISPLAY g_glam_m.oofa011 TO oofa011 #全名
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_person_desc(g_glam_m.glam015) RETURNING g_glam_m.glam015_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam015_desc #160729-00009#1 add
            NEXT FIELD glam015                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.glam017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam017
            #add-point:ON ACTION controlp INFIELD glam017 name="input.c.glam017"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam017            #給予default值
            #給予arg
            #160729-00009#1--add--str--
            #agli060设置的产品类别限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'13',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'13',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_pjba001()                                #呼叫開窗

            LET g_glam_m.glam017 = g_qryparam.return1  
            DISPLAY g_glam_m.glam017 TO glam017          
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_project_desc(g_glam_m.glam017) RETURNING g_glam_m.glam017_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam017_desc #160729-00009#1 add
            NEXT FIELD glam017 
            #END add-point
 
 
         #Ctrlp:input.c.glam018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glam018
            #add-point:ON ACTION controlp INFIELD glam018 name="input.c.glam018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glam_m.glam018            #給予default值
            #給予arg
            IF NOT cl_null(g_glam_m.glam017) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_glam_m.glam017,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            #160729-00009#1--add--str--
            #agli060设置的产品类别限制条件
            #CALL s_voucher_get_glak_sql(g_glalld,'14',g_glam002) RETURNING l_glak_sql #161221-00054#1 mark
            CALL s_voucher_get_glak_sql(g_glalld,'14',l_wc) RETURNING l_glak_sql       #161221-00054#1
            LET g_qryparam.where = g_qryparam.where," AND ",l_glak_sql 
            #160729-00009#1--add--end
            
            CALL q_pjbb002()                                #呼叫開窗

            LET g_glam_m.glam018 = g_qryparam.return1  
            DISPLAY g_glam_m.glam018 TO glam018          
#            CALL aglt360_01_ref_show() #160729-00009#1 mark
            CALL s_desc_get_wbs_desc(g_glam_m.glam017,g_glam_m.glam018) RETURNING g_glam_m.glam018_desc #160729-00009#1 add
            DISPLAY BY NAME g_glam_m.glam018_desc #160729-00009#1 add
            NEXT FIELD glam018
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
   CLOSE WINDOW w_aglt360_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      IF p_flag = 'a' THEN
         RETURN '','','','','','','','','','','','',
                '','','','','','','','','','','','',
                '','',''
      ELSE
         RETURN 
           g_glam_m_t.glam007,g_glam_m_t.glam007_desc,g_glam_m_t.glam008,g_glam_m_t.glam008_desc,
           g_glam_m_t.glam009,g_glam_m_t.glam009_desc,g_glam_m_t.glam010,g_glam_m_t.glam010_desc,
           g_glam_m_t.glam011,g_glam_m_t.glam011_desc,g_glam_m_t.glam012,g_glam_m_t.glam012_desc,
           g_glam_m_t.glam013,g_glam_m_t.glam013_desc,g_glam_m_t.glam014,g_glam_m_t.glam014_desc,
           g_glam_m_t.glam015,g_glam_m_t.glam015_desc,
           g_glam_m_t.glam017,g_glam_m_t.glam017_desc,g_glam_m_t.glam018,g_glam_m_t.glam018_desc,
           g_glam_m_t.glam051,g_glam_m_t.glam052,g_glam_m_t.glam052_desc,
           g_glam_m_t.glam053,g_glam_m_t.glam053_desc
      END IF 
   END IF
 
   RETURN  g_glam_m.glam007,g_glam_m.glam007_desc,g_glam_m.glam008,g_glam_m.glam008_desc,
           g_glam_m.glam009,g_glam_m.glam009_desc,g_glam_m.glam010,g_glam_m.glam010_desc,
           g_glam_m.glam011,g_glam_m.glam011_desc,g_glam_m.glam012,g_glam_m.glam012_desc,
           g_glam_m.glam013,g_glam_m.glam013_desc,g_glam_m.glam014,g_glam_m.glam014_desc,
           g_glam_m.glam015,g_glam_m.glam015_desc,
           g_glam_m.glam017,g_glam_m.glam017_desc,g_glam_m.glam018,g_glam_m.glam018_desc,
#           g_glam_m_t.glam051,g_glam_m_t.glam052,g_glam_m_t.glam052_desc, #160729-00009#1 mark
#           g_glam_m_t.glam053,g_glam_m_t.glam053_desc #160729-00009#1 mark
           g_glam_m.glam051,g_glam_m.glam052,g_glam_m.glam052_desc, #160729-00009#1 add
           g_glam_m.glam053,g_glam_m.glam053_desc #160729-00009#1 add
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglt360_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aglt360_01.other_function" readonly="Y" >}
# 參考欄位取值
PRIVATE FUNCTION aglt360_01_ref_show()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam007
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam007_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam008
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam008_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam008_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam009
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam009_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam010
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam010_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam011
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam011_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam011_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam012
   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam012_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam012_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam013
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam013_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam013_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam014
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam014_desc
   
   LET g_glam_m.glam015_desc = ''
   SELECT ooag011 INTO g_glam_m.glam015_desc FROM ooag_t
    WHERE ooagent = g_enterprise AND ooag001 = g_glam_m.glam015
   DISPLAY g_glam_m.glam015_desc TO glam015_desc
   
#   INITIALIZE g_ref_fields TO NULL
#   LET g_ref_fields[1] = g_glam_m.glam016
#   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#   LET g_glam_m.glam016_desc = '', g_rtn_fields[1] , ''
#   DISPLAY BY NAME g_glam_m.glam016_desc
   #渠道
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam052
   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl004 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam052_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam052_desc
   #品牌
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glam_m.glam053
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glam_m.glam053_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_glam_m.glam053_desc
   
   #专案
   CALL s_desc_get_project_desc(g_glam_m.glam017) RETURNING g_glam_m.glam017_desc
   DISPLAY BY NAME g_glam_m.glam017_desc
   #WBS
   CALL s_desc_get_wbs_desc(g_glam_m.glam017,g_glam_m.glam018) RETURNING g_glam_m.glam018_desc
   DISPLAY BY NAME g_glam_m.glam018_desc
END FUNCTION
# glam007欄位檢查
PRIVATE FUNCTION aglt360_01_glam007_chk()
   DEFINE l_ooefstus     LIKE ooef_t.ooefstus
   
   LET g_errno = ''
   
   SELECT ooefstus INTO l_ooefstus FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_glam_m.glam007   
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'aoo-00088'
      WHEN l_ooefstus = 'N'       LET g_errno = 'sub-01302'  #160318-00005#18 mod#'aoo-00089'
   END CASE
END FUNCTION
# glam008,glam009欄位檢查
PRIVATE FUNCTION aglt360_01_glam008_chk(p_ooef001)
   DEFINE l_ooegstus     LIKE ooeg_t.ooegstus
   DEFINE p_ooef001      LIKE ooef_t.ooef001

   LET g_errno = ''
   
   SELECT ooegstus INTO l_ooegstus FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = p_ooef001
      AND ooeg006 <= g_glaldocdt
      AND (ooeg007 IS NULL OR ooeg007 >= g_glaldocdt ) 
   CASE
      WHEN SQLCA.SQLCODE = 100    LET g_errno = 'abm-00006'
      WHEN l_ooegstus = 'N'       LET g_errno = 'sub-01302'  #160318-00005#18 mod#'abm-00007'
   END CASE
END FUNCTION
# 區域客群欄位檢查
PRIVATE FUNCTION aglt360_01_glam010_chk(p_oocq001,p_oocq002)
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
           LET g_errno = 'sub-01303'  #160318-00005#18 mod 'apm-00092'
        ELSE
           LET g_errno = 'axm-00003'  
        END IF 
     
     WHEN l_oocqstus = 'N'
        IF p_oocq001 = '287' THEN    
           LET g_errno =  'sub-01302'  #160318-00005#18 mod'apm-00093' 
        ELSE
           LET g_errno = 'sub-01302'  #160318-00005#18 mod'axm-00004' 
        END IF       
   END CASE
END FUNCTION
# 交易客商/帳款客商欄位檢查
PRIVATE FUNCTION aglt360_01_glam011_chk(p_pmaa001)
   DEFINE p_pmaa002     LIKE pmaa_t.pmaa002
   DEFINE p_pmaa001     LIKE pmaa_t.pmaa001
   DEFINE l_pmaastus    LIKE pmaa_t.pmaastus

   LET g_errno = ''
   SELECT pmaastus INTO l_pmaastus FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = p_pmaa001

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'apm-00028'
      WHEN l_pmaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#18 mod#'apm-00029'
   END CASE
END FUNCTION
# glam014產品類別欄位檢查
PRIVATE FUNCTION aglt360_01_glam014_chk()
   DEFINE l_rtaxstus  LIKE rtax_t.rtaxstus

   LET g_errno = ''
   SELECT rtaxstus INTO l_rtaxstus FROM rtax_t
    WHERE rtaxent = g_enterprise
      AND rtax001 = g_glam_m.glam014

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'aoo-00137'
      WHEN l_rtaxstus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#18 mod'aoo-00138'
   END CASE
END FUNCTION
# glam014人員欄位檢查
PRIVATE FUNCTION aglt360_01_glam015_chk()
   DEFINE l_ooagstus  LIKE ooag_t.ooagstus


   LET g_errno=''
   SELECT ooagstus INTO l_ooagstus FROM ooag_t
    WHERE ooagent = g_enterprise
      AND ooag001 = g_glam_m.glam015

   CASE
      WHEN SQLCA.SQLCODE=100   LET g_errno = 'aoo-00074'
      WHEN l_ooagstus ='N'     LET g_errno = 'sub-01302'  #160318-00005#18 mod'aoo-00071'
   END CASE
END FUNCTION
# glam016預算編號欄位檢查
PRIVATE FUNCTION aglt360_01_glam016_chk()
   DEFINE l_bgaastus    LIKE bgaa_t.bgaastus
    
   LET g_errno = ''
#   SELECT bgaastus INTO l_bgaastus FROM bgaa_t
#    WHERE bgaaent = g_enterprise
#      AND bgaa001 = g_glam_m.glam016

   CASE
      WHEN SQLCA.SQLCODE = 100   LET g_errno = 'abg-00007'
      WHEN l_bgaastus = 'N'      LET g_errno = 'sub-01302'  #160318-00005#18 mod'abg-00008'
   END CASE
END FUNCTION
# 根據判斷是否啟用核算項來控制核算項欄位
PRIVATE FUNCTION aglt360_01_visible()
   #科目核算项
   DEFINE l_glad005       LIKE glad_t.glad005
   DEFINE l_glad007       LIKE glad_t.glad007
   DEFINE l_glad008       LIKE glad_t.glad008
   DEFINE l_glad009       LIKE glad_t.glad009
   DEFINE l_glad010       LIKE glad_t.glad010
   DEFINE l_glad011       LIKE glad_t.glad011
   DEFINE l_glad012       LIKE glad_t.glad012
   DEFINE l_glad013       LIKE glad_t.glad013
   DEFINE l_glad015       LIKE glad_t.glad015
   DEFINE l_glad016       LIKE glad_t.glad016
   DEFINE l_glad027       LIKE glad_t.glad027
   DEFINE l_glad031       LIKE glad_t.glad031
   DEFINE l_glad032       LIKE glad_t.glad032
   DEFINE l_glad033       LIKE glad_t.glad033
   #记录隐藏栏位标示
   DEFINE l_flag1         LIKE type_t.num5
   DEFINE l_flag2         LIKE type_t.num5 
   #160729-00009#1--add--str--
   DEFINE l_glak002       LIKE glak_t.glak002 
   DEFINE l_gzcb002       LIKE gzcb_t.gzcb002
   DEFINE l_str           STRING
   DEFINE l_sql           STRING
   #160729-00009#1--add--end   
   
   LET l_flag1 = 0
   LET l_flag2 = 0  
   
   #依據是否啟用帳別，科目編號，判斷該科目是否做部門管理， 利潤成本中心管理，區域管理，客商管理，客群管理，產品類別，人員，預算，專案，wbs管理
   CALL s_voucher_fix_acc_open_chk(g_glalld,g_glam002)
   RETURNING l_glad007,l_glad008,l_glad009,l_glad010,l_glad027,l_glad011,l_glad012,l_glad013,l_glad015,l_glad016,l_glad031,l_glad032,l_glad033
   #該科目做部門管理時，部門不可空白,否则隐藏  
   IF l_glad007 = 'Y' THEN     
      CALL cl_set_comp_visible('glam008,glam008_desc',TRUE) 
#      IF g_flag = 'a' THEN 
#         LET g_glam_m.glam008 = g_ooag003
#         DISPLAY g_glam_m.glam008 TO glam008 
#      END IF 
   ELSE
      CALL cl_set_comp_visible('glam008,glam008_desc',FALSE) 
      LET g_glam_m.glam008 = ' '
   END IF 
   #該科目做利潤成本管理時，利潤成本不可空白,否则隐藏  
   IF l_glad008 = 'Y' THEN       
      CALL cl_set_comp_visible('glam009,glam009_desc',TRUE) 
#      IF g_flag = 'a' THEN 
#         LET g_glam_m.glam009 = g_ooeg004
#         DISPLAY g_glam_m.glam009 TO glam009  
#      END IF
   ELSE
      CALL cl_set_comp_visible('glam009,glam009_desc',FALSE)  
      LET g_glam_m.glam009 = ' '
   END IF 
   #該科目做區域管理時，區域不可空白 ,否则隐藏 
   IF l_glad009 = 'Y' THEN     
      CALL cl_set_comp_visible('glam010,glam010_desc',TRUE) 
      IF cl_null(g_glam_m.glam010) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'4') RETURNING g_glam_m.glam010
      END IF
   ELSE
      CALL cl_set_comp_visible('glam010,glam010_desc',FALSE)
      LET g_glam_m.glam010 = ' '
   END IF 
   #該科目做客商管理時，客商不可空白 ,否则隐藏 
   IF l_glad010 = 'Y' THEN 
      CALL cl_set_comp_visible('glam011,glam011_desc',TRUE)
      IF cl_null(g_glam_m.glam011) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'5') RETURNING g_glam_m.glam011
      END IF
   ELSE
       CALL cl_set_comp_visible('glam011,glam011_desc',FALSE)
       LET g_glam_m.glam011 = ' '
   END IF 
   #該科目做帳款客商管理時，帳款客商不可空白 ,否则隐藏 
   IF l_glad027 = 'Y' THEN 
      CALL cl_set_comp_visible('glam012,glam012_desc',TRUE)
      IF cl_null(g_glam_m.glam012) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'6') RETURNING g_glam_m.glam012
      END IF
   ELSE
       CALL cl_set_comp_visible('glam012,glam012_desc',FALSE)
       LET g_glam_m.glam012 = ' '
   END IF 
   #該科目做客群管理時，客群不可空白,否则隐藏  
   IF l_glad011 = 'Y' THEN 
      CALL cl_set_comp_visible('glam013,glam013_desc',TRUE)
      IF cl_null(g_glam_m.glam013) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'7') RETURNING g_glam_m.glam013
      END IF
   ELSE
      CALL cl_set_comp_visible('glam013,glam013_desc',FALSE)
      LET g_glam_m.glam013 = ' '
   END IF 
   
   #該科目做產品分類管理時，部門不可空白,否则隐藏  
   IF l_glad012 = 'Y' THEN      
      CALL cl_set_comp_visible('glam014,glam014_desc',TRUE)
      IF cl_null(g_glam_m.glam014) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'8') RETURNING g_glam_m.glam014
      END IF
   ELSE
      CALL cl_set_comp_visible('glam014,glam014_desc',FALSE)
      LET g_glam_m.glam014 = ' '
      LET l_flag2 = l_flag2+1      
   END IF 
   #該科目做經營方式管理時，經營方式不可空白,否则隐藏  
   IF l_glad031 = 'Y' THEN      
      CALL cl_set_comp_visible('glam051',TRUE)
      IF cl_null(g_glam_m.glam051) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'9') RETURNING g_glam_m.glam051
      END IF
   ELSE
      CALL cl_set_comp_visible('glam051',FALSE)
      LET g_glam_m.glam051 = ' '
      LET l_flag2 = l_flag2+1      
   END IF
   #該科目做渠道管理時，渠道不可空白,否则隐藏  
   IF l_glad032 = 'Y' THEN      
      CALL cl_set_comp_visible('glam052,glam052_desc',TRUE)
      IF cl_null(g_glam_m.glam052) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'10') RETURNING g_glam_m.glam052
      END IF
   ELSE
      CALL cl_set_comp_visible('glam052,glam052_desc',FALSE)
      LET g_glam_m.glam052 = ' '
      LET l_flag2 = l_flag2+1      
   END IF 
   #該科目做品牌管理時，品牌不可空白,否则隐藏  
   IF l_glad033 = 'Y' THEN      
      CALL cl_set_comp_visible('glam053,glam053_desc',TRUE)
      IF cl_null(g_glam_m.glam053) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'11') RETURNING g_glam_m.glam053
      END IF
   ELSE
      CALL cl_set_comp_visible('glam053,glam053_desc',FALSE)
      LET g_glam_m.glam053 = ' '
      LET l_flag2 = l_flag2+1      
   END IF 
   #該科目做人員管理時，部門不可空白,否则隐藏  
   IF l_glad013 = 'Y' THEN      
      CALL cl_set_comp_visible('glam015,glam015_desc',TRUE) 
#      IF g_flag = 'a' THEN 
#         LET g_glam_m.glam015 = g_user
#         DISPLAY g_glam_m.glam015 TO glam015
#      END IF
   ELSE
      CALL cl_set_comp_visible('glam015,glam015_desc',FALSE)
      LET g_glam_m.glam015 = ' '
      LET l_flag2 = l_flag2+1      
   END IF 
#   #該科目做預算管理時，部門不可空白,否则隐藏  
#   IF l_glad014 = 'Y' THEN     
#      CALL cl_set_comp_required('glam016',TRUE)
#   ELSE
#      CALL cl_set_comp_visible('glam016,glam016_desc',FALSE)
#      LET l_flag2 = l_flag2+1      
#   END IF 
   #該科目做專案管理時，部門不可空白,否则隐藏  
   IF l_glad015 = 'Y' THEN
      CALL cl_set_comp_visible('glam017,glam017_desc',TRUE)
      IF cl_null(g_glam_m.glam017) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'13') RETURNING g_glam_m.glam017
      END IF
   ELSE
      CALL cl_set_comp_visible('glam017,glam017_desc',FALSE)
      LET g_glam_m.glam017 = ' '
      LET l_flag2 = l_flag2+1      
   END IF 
   #該科目做WBS管理時，部門不可空白,否则隐藏  
   IF l_glad016 = 'Y' THEN 
      CALL cl_set_comp_visible('glam018,glam018_desc',TRUE)
      IF cl_null(g_glam_m.glam018) THEN
         CALL s_voucher_get_fix_default_value(g_glalld,g_glam002,'14') RETURNING g_glam_m.glam018
      END IF
   ELSE
      CALL cl_set_comp_visible('glam018,glam018_desc',FALSE)
      LET g_glam_m.glam018 = ' '
      LET l_flag2 = l_flag2+1
      #如果该页签上的栏位都已隐藏，则隐藏该gird
      IF l_flag2 = '7' THEN
         CALL cl_set_comp_visible('Grid_gen1',FALSE)
      ELSE
         CALL cl_set_comp_visible('Grid_gen1',TRUE)      
      END IF 
   END IF
   
   #160729-00009#1--add--str--
   #经营方式
   #当agli060设置了限制录入内容，下拉框内容需要按照限制内容加载
   IF l_glad031 = 'Y' THEN 
      LET l_glak002=''
      SELECT DISTINCT glak002 INTO l_glak002 FROM glak_t
       WHERE glakent=g_enterprise AND glakld=g_glalld AND glak001='09' 
         AND glak003=g_glam002
      IF NOT cl_null(l_glak002) THEN
         LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '6013'"
         #正向（允许）
         IF l_glak002 = '1' THEN
            LET l_sql = l_sql," AND gzcb002 IN "
         ELSE
         #反向(拒绝)
            LET l_sql = l_sql," AND gzcb002 NOT IN "
         END IF
         LET l_sql = l_sql," (SELECT glak004 FROM glak_t ",
                           "   WHERE glakent=",g_enterprise," AND glakld='",g_glalld,"'",
                           "     AND glak001='09' AND glak003='",g_glam002,"')",
                           " ORDER BY gzcb002 ASC"
         PREPARE glam051_pre FROM l_sql
         DECLARE glam051_cur CURSOR FOR glam051_pre
         LET l_str = NULL
         LET l_gzcb002 = NULL
         FOREACH glam051_cur INTO l_gzcb002
            IF cl_null(l_str) THEN LET l_str = l_gzcb002 CONTINUE FOREACH END IF
            LET l_str = l_str,",",l_gzcb002
         END FOREACH
         CALL cl_set_combo_scc_part('glam051','6013',l_str)
      ELSE
         CALL cl_set_combo_scc('glam051','6013')
      END IF 
   END IF 
   #160729-00009#1--add--end
END FUNCTION

 
{</section>}
 

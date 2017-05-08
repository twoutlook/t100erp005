#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt030_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-16 16:18:34), PR版次:0001(2016-11-25 16:29:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgt030_01
#+ Description: 核算項維護
#+ Creator....: 05016(2016-11-16 15:55:33)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgt030_01.global" >}
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
PRIVATE type type_g_bgbb_m        RECORD
       bgbb011 LIKE bgbb_t.bgbb011, 
   bgbb011_desc LIKE type_t.chr80, 
   bgbb012 LIKE bgbb_t.bgbb012, 
   bgbb012_desc LIKE type_t.chr80, 
   bgbb013 LIKE bgbb_t.bgbb013, 
   bgbb013_desc LIKE type_t.chr80, 
   bgbb014 LIKE bgbb_t.bgbb014, 
   bgbb014_desc LIKE type_t.chr80, 
   bgbb015 LIKE bgbb_t.bgbb015, 
   bgbb015_desc LIKE type_t.chr80, 
   bgbb016 LIKE bgbb_t.bgbb016, 
   bgbb016_desc LIKE type_t.chr80, 
   bgbb017 LIKE bgbb_t.bgbb017, 
   bgbb017_desc LIKE type_t.chr80, 
   bgbb018 LIKE bgbb_t.bgbb018, 
   bgbb018_desc LIKE type_t.chr80, 
   bgbb019 LIKE bgbb_t.bgbb019, 
   bgbb019_desc LIKE type_t.chr80, 
   bgbb020 LIKE bgbb_t.bgbb020, 
   bgbb020_desc LIKE type_t.chr80, 
   bgbb021 LIKE bgbb_t.bgbb021, 
   bgbb022 LIKE bgbb_t.bgbb022, 
   bgbb022_desc LIKE type_t.chr80, 
   bgbb023 LIKE bgbb_t.bgbb023, 
   bgbb023_desc LIKE type_t.chr80, 
   bgbb024 LIKE bgbb_t.bgbb024, 
   bgbb024_desc LIKE type_t.chr80, 
   bgbb025 LIKE bgbb_t.bgbb025, 
   bgbb026 LIKE bgbb_t.bgbb026, 
   bgbb027 LIKE bgbb_t.bgbb027, 
   bgbb028 LIKE bgbb_t.bgbb028, 
   bgbb029 LIKE bgbb_t.bgbb029, 
   bgbb030 LIKE bgbb_t.bgbb030, 
   bgbb031 LIKE bgbb_t.bgbb031, 
   bgbb032 LIKE bgbb_t.bgbb032, 
   bgbb033 LIKE bgbb_t.bgbb033, 
   bgbb034 LIKE bgbb_t.bgbb034
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_bgbb_r        RECORD   
   bgbb011 LIKE bgbb_t.bgbb011, 
   bgbb012 LIKE bgbb_t.bgbb012, 
   bgbb013 LIKE bgbb_t.bgbb013, 
   bgbb014 LIKE bgbb_t.bgbb014, 
   bgbb015 LIKE bgbb_t.bgbb015, 
   bgbb016 LIKE bgbb_t.bgbb016, 
   bgbb017 LIKE bgbb_t.bgbb017, 
   bgbb018 LIKE bgbb_t.bgbb018, 
   bgbb019 LIKE bgbb_t.bgbb019, 
   bgbb020 LIKE bgbb_t.bgbb020, 
   bgbb021 LIKE bgbb_t.bgbb021, 
   bgbb022 LIKE bgbb_t.bgbb022, 
   bgbb023 LIKE bgbb_t.bgbb023, 
   bgbb024 LIKE bgbb_t.bgbb024, 
   bgbb025 LIKE bgbb_t.bgbb025, 
   bgbb026 LIKE bgbb_t.bgbb026, 
   bgbb027 LIKE bgbb_t.bgbb027, 
   bgbb028 LIKE bgbb_t.bgbb028, 
   bgbb029 LIKE bgbb_t.bgbb029, 
   bgbb030 LIKE bgbb_t.bgbb030, 
   bgbb031 LIKE bgbb_t.bgbb031, 
   bgbb032 LIKE bgbb_t.bgbb032, 
   bgbb033 LIKE bgbb_t.bgbb033, 
   bgbb034 LIKE bgbb_t.bgbb034
       END RECORD
DEFINE g_bgbb_m_t       type_g_bgbb_m
DEFINE g_bgbb_r         type_g_bgbb_r       
DEFINE g_bgba001       LIKE bgba_t.bgba001
DEFINE g_bgba005       LIKE bgba_t.bgba005
DEFINE g_bgaa009       LIKE bgaa_t.bgaa009
#end add-point
 
DEFINE g_bgbb_m        type_g_bgbb_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgt030_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt030_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_docno,p_seq,p_bgbb002
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
   DEFINE p_docno         LIKE bgbb_t.bgbbdocno
   DEFINE p_seq           LIKE bgbb_t.bgbbseq
   DEFINE p_bgbb002       LIKE bgbb_t.bgbb002 #預算細項
   DEFINE l_array DYNAMIC ARRAY OF RECORD
                  chr1   LIKE type_t.chr1
                  END RECORD
   DEFINE l_bgae036       LIKE bgae_t.bgae036 #現金                  
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt030_01 WITH FORM cl_ap_formpath("abg","abgt030_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('bgbb021','6013')
   #根據預算樣表abgi110是否開啟欄位
   #預算編號，部門
   SELECT bgba001,bgba005 INTO g_bgba001,g_bgba005
     FROM bgba_t WHERE bgbaent = g_enterprise AND bgbadocno = p_docno 
   #是否是現金科目
   LET l_bgae036 = ''
   SELECT bgae036 INTO l_bgae036 FROM bgae_t
    WHERE bgaeent = g_enterprise 
      AND bgae006 = (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgba001 )
      AND bgae001 = p_bgbb002
  
   LET g_bgaa009 = ''
   SELECT bgaa009 INTO g_bgaa009 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgba001
    
   CALL s_abg_used_cond(g_bgba005,g_bgba001,p_bgbb002)
            RETURNING l_array
   INITIALIZE g_bgbb_m.* TO NULL
   SELECT bgbb011,bgbb012,bgbb013,bgbb014,bgbb015,
          bgbb016,bgbb017,bgbb018,bgbb019,bgbb020,
          bgbb021,bgbb022,bgbb023,bgbb024 
     INTO g_bgbb_m.bgbb011,g_bgbb_m.bgbb012,g_bgbb_m.bgbb013,g_bgbb_m.bgbb014,g_bgbb_m.bgbb015,
          g_bgbb_m.bgbb016,g_bgbb_m.bgbb017,g_bgbb_m.bgbb018,g_bgbb_m.bgbb019,g_bgbb_m.bgbb020,
          g_bgbb_m.bgbb021,g_bgbb_m.bgbb022,g_bgbb_m.bgbb023,g_bgbb_m.bgbb024
      FROM bgbb_t WHERE bgbbent = g_enterprise
       AND bgbbdocno = p_docno AND bgbbseq = p_seq
   
     CALL s_desc_get_department_desc(g_bgbb_m.bgbb011) RETURNING g_bgbb_m.bgbb011_desc           
     CALL s_desc_get_department_desc(g_bgbb_m.bgbb012) RETURNING g_bgbb_m.bgbb012_desc           
     CALL s_desc_get_acc_desc('287',g_bgbb_m.bgbb013) RETURNING g_bgbb_m.bgbb013_desc            
     CALL s_desc_get_trading_partner_abbr_desc(g_bgbb_m.bgbb014) RETURNING g_bgbb_m.bgbb014_desc 
     CALL s_desc_get_trading_partner_abbr_desc(g_bgbb_m.bgbb015) RETURNING g_bgbb_m.bgbb015_desc 
     CALL s_desc_get_acc_desc('281',g_bgbb_m.bgbb016) RETURNING g_bgbb_m.bgbb016_desc            
     CALL s_desc_get_rtaxl003_desc(g_bgbb_m.bgbb017) RETURNING g_bgbb_m.bgbb017_desc
     CALL s_desc_get_person_desc(g_bgbb_m.bgbb018) RETURNING g_bgbb_m.bgbb018_desc               
     CALL s_desc_get_project_desc(g_bgbb_m.bgbb019) RETURNING g_bgbb_m.bgbb019_desc              
     CALL s_desc_get_wbs_desc(g_bgbb_m.bgbb027,g_bgbb_m.bgbb020) RETURNING g_bgbb_m.bgbb020_desc 
     CALL s_desc_get_oojdl003_desc(g_bgbb_m.bgbb022) RETURNING g_bgbb_m.bgbb022_desc             
     CALL s_desc_get_acc_desc('2002',g_bgbb_m.bgbb023) RETURNING g_bgbb_m.bgbb023_desc           
                                                                                            
   DISPLAY BY NAME g_bgbb_m.bgbb011,g_bgbb_m.bgbb012,g_bgbb_m.bgbb013,g_bgbb_m.bgbb014,g_bgbb_m.bgbb015,
                   g_bgbb_m.bgbb016,g_bgbb_m.bgbb017,g_bgbb_m.bgbb018,g_bgbb_m.bgbb019,g_bgbb_m.bgbb020,
                   g_bgbb_m.bgbb021,g_bgbb_m.bgbb022,g_bgbb_m.bgbb023,g_bgbb_m.bgbb024,
                   g_bgbb_m.bgbb011_desc,g_bgbb_m.bgbb012_desc,g_bgbb_m.bgbb013_desc,g_bgbb_m.bgbb014_desc,
                   g_bgbb_m.bgbb015_desc,g_bgbb_m.bgbb016_desc,g_bgbb_m.bgbb017_desc,g_bgbb_m.bgbb018_desc,
                   g_bgbb_m.bgbb019_desc,g_bgbb_m.bgbb020_desc,g_bgbb_m.bgbb022_desc,g_bgbb_m.bgbb023_desc                                                                                              
          
   
   LET g_bgbb_m_t.* = g_bgbb_m.*

   CALL cl_set_comp_visible('bgbb011,bgbb011_desc,bgbb012,bgbb012_desc,bgbb013,bgbb013_desc,
                             bgbb014,bgbb014_desc,bgbb015,bgbb015_desc,bgbb016,bgbb016_desc,
                             bgbb017,bgbb017_desc,bgbb018,bgbb018_desc,bgbb019,bgbb019_desc,
                             bgbb020,bgbb020_desc,bgbb021,bgbb022,bgbb022_desc,
                             bgbb023,bgbb023_desc,bgbb024,bgbb024_desc',TRUE)
   #現金變動碼                             
   IF l_bgae036 != '1' THEN
      CALL cl_set_comp_visible('bgbb024,bgbb024_desc',FALSE)
      LET g_bgbb_m.bgbb024 = ' ' 
   ELSE
      IF cl_null(g_bgbb_m.bgbb024) THEN
         SELECT bgad004 INTO g_bgbb_m.bgbb024 FROM bgad_t WHERE bgadent = g_enterprise
            AND bgad001 = (SELECT bgaa008 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgba001)
            AND bgad003 = (SELECT bgaa009 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_bgba001)
            AND bgad002 = p_bgbb002
      END IF   
   END IF
   
   IF l_array[2].chr1 = 'N'  THEN  #部門
      CALL cl_set_comp_visible('bgbb011,bgbb011_desc',FALSE) 
      LET g_bgbb_m.bgbb011 = ' '      
   END IF 
   IF l_array[3].chr1 = 'N'  THEN #利潤中心
      CALL cl_set_comp_visible('bgbb012,bgbb012_desc',FALSE) 
      LET g_bgbb_m.bgbb012 = ' ' 
   END IF 
   IF l_array[4].chr1 = 'N'  THEN #區域
      CALL cl_set_comp_visible('bgbb013,bgbb013_desc',FALSE) 
      LET g_bgbb_m.bgbb013 = ' ' 
   END IF 
   IF l_array[5].chr1 = 'N'  THEN #交易客商
      CALL cl_set_comp_visible('bgbb014,bgbb014_desc',FALSE) 
      LET g_bgbb_m.bgbb014 = ' ' 
   END IF 
   IF l_array[6].chr1 = 'N'  THEN #收款客商
      CALL cl_set_comp_visible('bgbb015,bgbb015_desc',FALSE) 
      LET g_bgbb_m.bgbb015 = ' ' 
   END IF 
   IF l_array[7].chr1 = 'N'  THEN #客群
      CALL cl_set_comp_visible('bgbb016,bgbb016_desc',FALSE) 
      LET g_bgbb_m.bgbb016 = ' ' 
   END IF 
   IF l_array[8].chr1 = 'N'  THEN #產品類別
      CALL cl_set_comp_visible('bgbb017,bgbb017_desc',FALSE) 
      LET g_bgbb_m.bgbb017 = ' ' 
   END IF 
   IF l_array[9].chr1 = 'N'  THEN #人員
      CALL cl_set_comp_visible('bgbb018,bgbb018_desc',FALSE) 
      LET g_bgbb_m.bgbb018 = ' ' 
   END IF 
   IF l_array[10].chr1 = 'N' THEN #專案編號
      CALL cl_set_comp_visible('bgbb019,bgbb019_desc',FALSE) 
      LET g_bgbb_m.bgbb019 = ' ' 
   END IF 
   IF l_array[11].chr1 = 'N' THEN #WBS
      CALL cl_set_comp_visible('bgbb020,bgbb020_desc',FALSE) 
      LET g_bgbb_m.bgbb020 = ' ' 
   END IF 
   IF l_array[12].chr1 = 'N' THEN   #經營方式
      CALL cl_set_comp_visible('bgbb021',FALSE) 
      LET g_bgbb_m.bgbb021 = ' ' 
   END IF             
   IF l_array[13].chr1 = 'N' THEN #渠道
      CALL cl_set_comp_visible('bgbb022,bgbb022_desc',FALSE) 
      LET g_bgbb_m.bgbb022 = ' ' 
   END IF 
   IF l_array[14].chr1 = 'N' THEN #品牌
      CALL cl_set_comp_visible('bgbb023,bgbb023_desc',FALSE) 
      LET g_bgbb_m.bgbb023 = ' ' 
   END IF 
   IF l_array[15].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb025,bgbb025_desc',FALSE) 
      LET g_bgbb_m.bgbb025 = ' ' 
   END IF #自由核算項一
   IF l_array[16].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb026,bgbb026_desc',FALSE) 
      LET g_bgbb_m.bgbb026 = ' ' 
   END IF
   IF l_array[17].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb027,bgbb027_desc',FALSE) 
      LET g_bgbb_m.bgbb027 = ' ' 
   END IF
   IF l_array[18].chr1 = 'N' THEN
      CALL cl_set_comp_visible('bgbb028,bgbb028_desc',FALSE) 
      LET g_bgbb_m.bgbb028 = ' ' 
   END IF
   IF l_array[19].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb029,bgbb029_desc',FALSE) 
      LET g_bgbb_m.bgbb029 = ' ' 
   END IF
   IF l_array[20].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb030,bgbb030_desc',FALSE) 
      LET g_bgbb_m.bgbb030 = ' ' 
   END IF
   IF l_array[21].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb031,bgbb031_desc',FALSE) 
      LET g_bgbb_m.bgbb031 = ' ' 
   END IF
   IF l_array[22].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb032,bgbb032_desc',FALSE) 
      LET g_bgbb_m.bgbb032 = ' ' 
   END IF
   IF l_array[23].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb033,bgbb033_desc',FALSE) 
      LET g_bgbb_m.bgbb033 = ' ' 
   END IF
   IF l_array[24].chr1 = 'N' THEN 
      CALL cl_set_comp_visible('bgbb034,bgbb034_desc',FALSE) 
      LET g_bgbb_m.bgbb034 = ' ' 
   END IF #自由核算項十 
   
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgbb_m.bgbb011,g_bgbb_m.bgbb012,g_bgbb_m.bgbb013,g_bgbb_m.bgbb014,g_bgbb_m.bgbb015, 
          g_bgbb_m.bgbb016,g_bgbb_m.bgbb017,g_bgbb_m.bgbb018,g_bgbb_m.bgbb019,g_bgbb_m.bgbb020,g_bgbb_m.bgbb021, 
          g_bgbb_m.bgbb022,g_bgbb_m.bgbb023,g_bgbb_m.bgbb024,g_bgbb_m.bgbb025,g_bgbb_m.bgbb026,g_bgbb_m.bgbb027, 
          g_bgbb_m.bgbb028,g_bgbb_m.bgbb029,g_bgbb_m.bgbb030,g_bgbb_m.bgbb031,g_bgbb_m.bgbb032,g_bgbb_m.bgbb033, 
          g_bgbb_m.bgbb034 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb011
            
            #add-point:AFTER FIELD bgbb011 name="input.a.bgbb011"
            #部門
            IF NOT cl_null(g_bgbb_m.bgbb011) THEN
               IF (g_bgbb_m.bgbb011 != g_bgbb_m_t.bgbb011 OR g_bgbb_m_t.bgbb011 IS NULL) THEN
                
                  CALL s_department_chk(g_bgbb_m.bgbb011,g_today) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_bgbb_m.bgbb011 = g_bgbb_m_t.bgbb011
                     LET g_bgbb_m.bgbb011_desc = s_desc_get_department_desc(g_bgbb_m.bgbb011)
                     DISPLAY BY NAME g_bgbb_m.bgbb011,g_bgbb_m.bgbb011_desc
                     NEXT FIELD CURRENT
                  END IF
                  #取責任中心
                  IF l_array[3].chr1='Y' AND cl_null(g_bgbb_m.bgbb012) THEN
                     CALL s_department_get_respon_center(g_bgbb_m.bgbb011,g_today)
                       RETURNING g_sub_success,g_errno,g_bgbb_m.bgbb012,g_bgbb_m.bgbb012_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb012,g_bgbb_m.bgbb012_desc
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb011 = ' '
            END IF
            LET g_bgbb_m.bgbb011_desc = s_desc_get_department_desc(g_bgbb_m.bgbb011)
            DISPLAY BY NAME g_bgbb_m.bgbb011,g_bgbb_m.bgbb011_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb011
            #add-point:BEFORE FIELD bgbb011 name="input.b.bgbb011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb011
            #add-point:ON CHANGE bgbb011 name="input.g.bgbb011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb012
            
            #add-point:AFTER FIELD bgbb012 name="input.a.bgbb012"
            #責任中心
            IF NOT cl_null(g_bgbb_m.bgbb012) THEN
               IF ( g_bgbb_m.bgbb012 != g_bgbb_m_t.bgbb012 OR g_bgbb_m_t.bgbb012 IS NULL ) THEN                
                  CALL s_voucher_glaq019_chk(g_bgbb_m.bgbb012,g_today)
                  IF NOT cl_null(g_errno) THEN
                     LET g_bgbb_m.bgbb012 = g_bgbb_m_t.bgbb012
                     LET g_bgbb_m.bgbb012_desc = s_desc_get_department_desc(g_bgbb_m.bgbb012)
                     DISPLAY BY NAME g_bgbb_m.bgbb012,g_bgbb_m.bgbb012_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb012 = ' '
            END IF
            LET g_bgbb_m.bgbb012_desc = s_desc_get_department_desc(g_bgbb_m.bgbb012)
            DISPLAY BY NAME g_bgbb_m.bgbb012,g_bgbb_m.bgbb012_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb012
            #add-point:BEFORE FIELD bgbb012 name="input.b.bgbb012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb012
            #add-point:ON CHANGE bgbb012 name="input.g.bgbb012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb013
            
            #add-point:AFTER FIELD bgbb013 name="input.a.bgbb013"
            #區域
            IF NOT cl_null(g_bgbb_m.bgbb013) THEN
               IF (g_bgbb_m.bgbb013 != g_bgbb_m_t.bgbb013 OR g_bgbb_m_t.bgbb013 IS NULL ) THEN                
                  IF NOT s_azzi650_chk_exist('287',g_bgbb_m.bgbb013) THEN
                     LET g_bgbb_m.bgbb013 = g_bgbb_m_t.bgbb013
                     LET g_bgbb_m.bgbb013_desc = s_desc_get_acc_desc('287',g_bgbb_m.bgbb013)
                     DISPLAY BY NAME g_bgbb_m.bgbb013,g_bgbb_m.bgbb013_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE 
               LET g_bgbb_m.bgbb013 = ' '
            END IF
            LET g_bgbb_m.bgbb013_desc = s_desc_get_acc_desc('287',g_bgbb_m.bgbb013)
            DISPLAY BY NAME g_bgbb_m.bgbb013,g_bgbb_m.bgbb013_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb013
            #add-point:BEFORE FIELD bgbb013 name="input.b.bgbb013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb013
            #add-point:ON CHANGE bgbb013 name="input.g.bgbb013"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb014
            
            #add-point:AFTER FIELD bgbb014 name="input.a.bgbb014"
            #交易客商
            IF NOT cl_null(g_bgbb_m.bgbb014) THEN
               IF ( g_bgbb_m.bgbb014 != g_bgbb_m_t.bgbb014 OR g_bgbb_m_t.bgbb014 IS NULL ) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgbb_m.bgbb014
                  LET g_chkparam.arg2 = ' '
                  LET g_errshow = TRUE  
                  LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    
                  IF NOT cl_chk_exist("v_pmaa001_7") THEN
                     LET g_bgbb_m.bgbb014 = g_bgbb_m_t.bgbb014
                     LET g_bgbb_m.bgbb014_desc = g_bgbb_m_t.bgbb014_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb014 ,g_bgbb_m.bgbb014_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb014 = ' '
            END IF
            LET g_bgbb_m.bgbb014_desc = s_desc_get_trading_partner_abbr_desc(g_bgbb_m.bgbb014)
            DISPLAY BY NAME g_bgbb_m.bgbb014 ,g_bgbb_m.bgbb014_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb014
            #add-point:BEFORE FIELD bgbb014 name="input.b.bgbb014"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb014
            #add-point:ON CHANGE bgbb014 name="input.g.bgbb014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb015
            
            #add-point:AFTER FIELD bgbb015 name="input.a.bgbb015"
            #收款客商
            IF NOT cl_null(g_bgbb_m.bgbb015) THEN
               IF (g_bgbb_m.bgbb015 != g_bgbb_m_t.bgbb015 OR g_bgbb_m_t.bgbb015 IS NULL) THEN               
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_bgbb_m.bgbb015
                  LET g_chkparam.arg2 = ' '
                  LET g_errshow = TRUE  
                  LET g_chkparam.err_str[1] = "apm-00201:sub-01302|axmm200|",cl_get_progname("axmm200",g_lang,"2"),"|:EXEPROGaxmm200"    #160318-00025#49
                  IF NOT cl_chk_exist("v_pmaa001_7") THEN
                     LET g_bgbb_m.bgbb015 = g_bgbb_m_t.bgbb015
                     LET g_bgbb_m.bgbb015_desc = g_bgbb_m_t.bgbb015_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb015 ,g_bgbb_m.bgbb015_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb015 = ' '
            END IF
            LET g_bgbb_m.bgbb015_desc = s_desc_get_trading_partner_abbr_desc(g_bgbb_m.bgbb015)
            DISPLAY BY NAME g_bgbb_m.bgbb015,g_bgbb_m.bgbb015_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb015
            #add-point:BEFORE FIELD bgbb015 name="input.b.bgbb015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb015
            #add-point:ON CHANGE bgbb015 name="input.g.bgbb015"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb016
            
            #add-point:AFTER FIELD bgbb016 name="input.a.bgbb016"
            #客群
            IF NOT cl_null(g_bgbb_m.bgbb016) THEN
               IF ( g_bgbb_m.bgbb016 != g_bgbb_m_t.bgbb016 OR g_bgbb_m_t.bgbb016 IS NULL ) THEN
                  IF NOT s_azzi650_chk_exist('281',g_bgbb_m.bgbb016) THEN
                     LET g_bgbb_m.bgbb016 = g_bgbb_m_t.bgbb016
                     LET g_bgbb_m.bgbb016_desc = g_bgbb_m_t.bgbb016_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb016 ,g_bgbb_m.bgbb016_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb016 = ' '
            END IF
            LET g_bgbb_m.bgbb016_desc = s_desc_get_acc_desc('281',g_bgbb_m.bgbb016)
            DISPLAY BY NAME g_bgbb_m.bgbb016 ,g_bgbb_m.bgbb016_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb016
            #add-point:BEFORE FIELD bgbb016 name="input.b.bgbb016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb016
            #add-point:ON CHANGE bgbb016 name="input.g.bgbb016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb017
            
            #add-point:AFTER FIELD bgbb017 name="input.a.bgbb017"
            #產品類別
            IF NOT cl_null(g_bgbb_m.bgbb017) THEN
               IF ( g_bgbb_m.bgbb017 != g_bgbb_m_t.bgbb017 OR g_bgbb_m_t.bgbb017 IS NULL ) THEN
                  CALL s_voucher_glaq024_chk(g_bgbb_m.bgbb017)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = g_errno
                     LET g_errparam.replace[1] = 'arti202'
                     LET g_errparam.replace[2] = cl_get_progname('arti202',g_lang,"2")
                     LET g_errparam.exeprog = 'arti202'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_bgbb_m.bgbb017 = g_bgbb_m_t.bgbb017
                     LET g_bgbb_m.bgbb017_desc = g_bgbb_m_t.bgbb017_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb017 ,g_bgbb_m.bgbb017_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb017 = ' '
            END IF
            LET g_bgbb_m.bgbb017_desc = s_desc_get_rtaxl003_desc(g_bgbb_m.bgbb017)
            DISPLAY BY NAME g_bgbb_m.bgbb017 ,g_bgbb_m.bgbb017_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb017
            #add-point:BEFORE FIELD bgbb017 name="input.b.bgbb017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb017
            #add-point:ON CHANGE bgbb017 name="input.g.bgbb017"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb018
            
            #add-point:AFTER FIELD bgbb018 name="input.a.bgbb018"
            #人員
            IF NOT cl_null(g_bgbb_m.bgbb018) THEN
               IF ( g_bgbb_m.bgbb018 != g_bgbb_m_t.bgbb018 OR g_bgbb_m_t.bgbb018 IS NULL ) THEN                 
                  CALL s_employee_chk(g_bgbb_m.bgbb018) RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     LET g_bgbb_m.bgbb018 = g_bgbb_m_t.bgbb018
                     LET g_bgbb_m.bgbb018_desc = g_bgbb_m_t.bgbb018_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb018,g_bgbb_m.bgbb018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb018 = ' '
            END IF
            LET g_bgbb_m.bgbb018_desc = s_desc_get_person_desc(g_bgbb_m.bgbb018)
            DISPLAY BY NAME g_bgbb_m.bgbb018,g_bgbb_m.bgbb018_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb018
            #add-point:BEFORE FIELD bgbb018 name="input.b.bgbb018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb018
            #add-point:ON CHANGE bgbb018 name="input.g.bgbb018"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb019
            
            #add-point:AFTER FIELD bgbb019 name="input.a.bgbb019"
            #專案代號
            IF NOT cl_null(g_bgbb_m.bgbb019) THEN
               IF ( g_bgbb_m.bgbb019 != g_bgbb_m_t.bgbb019 OR g_bgbb_m_t.bgbb019 IS NULL ) THEN             
                  CALL s_aap_project_chk( g_bgbb_m.bgbb019) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                      INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.replace[1] = 'apjm200'
                     LET g_errparam.replace[2] = cl_get_progname('apjm200',g_lang,"2")
                     LET g_errparam.exeprog = 'apjm200'
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgbb_m.bgbb019      = g_bgbb_m_t.bgbb019
                     LET g_bgbb_m.bgbb019_desc = g_bgbb_m_t.bgbb019_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb019,g_bgbb_m.bgbb019_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb019 = ' '
            END IF
            LET g_bgbb_m.bgbb019_desc = s_desc_get_project_desc(g_bgbb_m.bgbb019)
            DISPLAY BY NAME g_bgbb_m.bgbb019,g_bgbb_m.bgbb019_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb019
            #add-point:BEFORE FIELD bgbb019 name="input.b.bgbb019"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb019
            #add-point:ON CHANGE bgbb019 name="input.g.bgbb019"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb020
            
            #add-point:AFTER FIELD bgbb020 name="input.a.bgbb020"
            #WBS
            IF NOT cl_null(g_bgbb_m.bgbb020) THEN
               IF (g_bgbb_m.bgbb020 != g_bgbb_m_t.bgbb020 OR g_bgbb_m_t.bgbb020 IS NULL) THEN   
                  CALL s_voucher_glaq028_chk(g_bgbb_m.bgbb019,g_bgbb_m.bgbb020)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgbb_m.bgbb020      = g_bgbb_m_t.bgbb020
                     LET g_bgbb_m.bgbb020_desc = g_bgbb_m_t.bgbb020_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb020,g_bgbb_m.bgbb020_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb020 = ' '
            END IF
            LET g_bgbb_m.bgbb020_desc = s_desc_get_pjbbl004_desc(g_bgbb_m.bgbb019,g_bgbb_m.bgbb020)
            DISPLAY BY NAME g_bgbb_m.bgbb020,g_bgbb_m.bgbb020_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb020
            #add-point:BEFORE FIELD bgbb020 name="input.b.bgbb020"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb020
            #add-point:ON CHANGE bgbb020 name="input.g.bgbb020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb021
            #add-point:BEFORE FIELD bgbb021 name="input.b.bgbb021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb021
            
            #add-point:AFTER FIELD bgbb021 name="input.a.bgbb021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb021
            #add-point:ON CHANGE bgbb021 name="input.g.bgbb021"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb022
            
            #add-point:AFTER FIELD bgbb022 name="input.a.bgbb022"
            #渠道
            IF NOT cl_null(g_bgbb_m.bgbb022) THEN
               IF ( g_bgbb_m.bgbb022 != g_bgbb_m_t.bgbb022 OR g_bgbb_m_t.bgbb022 IS NULL ) THEN
                  CALL s_voucher_glaq052_chk(g_bgbb_m.bgbb022)
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bgbb_m.bgbb022 = g_bgbb_m_t.bgbb022
                     LET g_bgbb_m.bgbb022_desc = g_bgbb_m_t.bgbb022_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb022,g_bgbb_m.bgbb022_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb022 = ' '
            END IF
            LET g_bgbb_m.bgbb022_desc = s_desc_get_oojdl003_desc(g_bgbb_m.bgbb022)
            DISPLAY BY NAME g_bgbb_m.bgbb022,g_bgbb_m.bgbb022_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb022
            #add-point:BEFORE FIELD bgbb022 name="input.b.bgbb022"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb022
            #add-point:ON CHANGE bgbb022 name="input.g.bgbb022"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb023
            
            #add-point:AFTER FIELD bgbb023 name="input.a.bgbb023"
            #品牌
            IF NOT cl_null(g_bgbb_m.bgbb023) THEN
               IF ( g_bgbb_m.bgbb023 != g_bgbb_m_t.bgbb023 OR g_bgbb_m_t.bgbb023 IS NULL ) THEN                 
                  IF NOT s_azzi650_chk_exist('2002',g_bgbb_m.bgbb023) THEN
                     LET g_bgbb_m.bgbb023      = g_bgbb_m_t.bgbb023
                     LET g_bgbb_m.bgbb023_desc = g_bgbb_m_t.bgbb023_desc
                     DISPLAY BY NAME g_bgbb_m.bgbb023 ,g_bgbb_m.bgbb023_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE
               LET g_bgbb_m.bgbb023 = ' '
            END IF
            LET g_bgbb_m.bgbb023_desc = s_desc_get_acc_desc('2002',g_bgbb_m.bgbb023)
            DISPLAY BY NAME g_bgbb_m.bgbb023 ,g_bgbb_m.bgbb023_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb023
            #add-point:BEFORE FIELD bgbb023 name="input.b.bgbb023"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb023
            #add-point:ON CHANGE bgbb023 name="input.g.bgbb023"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb024
            
            #add-point:AFTER FIELD bgbb024 name="input.a.bgbb024"
            IF NOT cl_null(g_bgbb_m.bgbb024) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_bgbb_m.bgbb024
               LET g_chkparam.arg2 = g_bgaa009
               LET g_errshow = TRUE
               IF NOT cl_chk_exist("v_nmai002") THEN
                  LET g_bgbb_m.bgbb024      = g_bgbb_m_t.bgbb024        
                  LET g_bgbb_m.bgbb024_desc = g_bgbb_m_t.bgbb024_desc
                  DISPLAY BY NAME g_bgbb_m.bgbb024,g_bgbb_m.bgbb024_desc
                  NEXT FIELD CURRENT
               END IF
            ELSE
               LET g_bgbb_m.bgbb024  = ' '
            END IF
            LET g_bgbb_m.bgbb024_desc = s_desc_get_nmail004_desc(g_bgaa009,g_bgbb_m.bgbb024)
            DISPLAY BY NAME g_bgbb_m.bgbb024,g_bgbb_m.bgbb024_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb024
            #add-point:BEFORE FIELD bgbb024 name="input.b.bgbb024"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb024
            #add-point:ON CHANGE bgbb024 name="input.g.bgbb024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb025
            #add-point:BEFORE FIELD bgbb025 name="input.b.bgbb025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb025
            
            #add-point:AFTER FIELD bgbb025 name="input.a.bgbb025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb025
            #add-point:ON CHANGE bgbb025 name="input.g.bgbb025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb026
            #add-point:BEFORE FIELD bgbb026 name="input.b.bgbb026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb026
            
            #add-point:AFTER FIELD bgbb026 name="input.a.bgbb026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb026
            #add-point:ON CHANGE bgbb026 name="input.g.bgbb026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb027
            #add-point:BEFORE FIELD bgbb027 name="input.b.bgbb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb027
            
            #add-point:AFTER FIELD bgbb027 name="input.a.bgbb027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb027
            #add-point:ON CHANGE bgbb027 name="input.g.bgbb027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb028
            #add-point:BEFORE FIELD bgbb028 name="input.b.bgbb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb028
            
            #add-point:AFTER FIELD bgbb028 name="input.a.bgbb028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb028
            #add-point:ON CHANGE bgbb028 name="input.g.bgbb028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb029
            #add-point:BEFORE FIELD bgbb029 name="input.b.bgbb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb029
            
            #add-point:AFTER FIELD bgbb029 name="input.a.bgbb029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb029
            #add-point:ON CHANGE bgbb029 name="input.g.bgbb029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb030
            #add-point:BEFORE FIELD bgbb030 name="input.b.bgbb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb030
            
            #add-point:AFTER FIELD bgbb030 name="input.a.bgbb030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb030
            #add-point:ON CHANGE bgbb030 name="input.g.bgbb030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb031
            #add-point:BEFORE FIELD bgbb031 name="input.b.bgbb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb031
            
            #add-point:AFTER FIELD bgbb031 name="input.a.bgbb031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb031
            #add-point:ON CHANGE bgbb031 name="input.g.bgbb031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb032
            #add-point:BEFORE FIELD bgbb032 name="input.b.bgbb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb032
            
            #add-point:AFTER FIELD bgbb032 name="input.a.bgbb032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb032
            #add-point:ON CHANGE bgbb032 name="input.g.bgbb032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb033
            #add-point:BEFORE FIELD bgbb033 name="input.b.bgbb033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb033
            
            #add-point:AFTER FIELD bgbb033 name="input.a.bgbb033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb033
            #add-point:ON CHANGE bgbb033 name="input.g.bgbb033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgbb034
            #add-point:BEFORE FIELD bgbb034 name="input.b.bgbb034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgbb034
            
            #add-point:AFTER FIELD bgbb034 name="input.a.bgbb034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgbb034
            #add-point:ON CHANGE bgbb034 name="input.g.bgbb034"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgbb011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb011
            #add-point:ON ACTION controlp INFIELD bgbb011 name="input.c.bgbb011"
            #部門
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb011
            LET g_qryparam.arg1 = g_today    #應以單據日期
            CALL q_ooeg001_4()
            LET g_bgbb_m.bgbb011 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb011
            NEXT FIELD bgbb011
            #END add-point
 
 
         #Ctrlp:input.c.bgbb012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb012
            #add-point:ON ACTION controlp INFIELD bgbb012 name="input.c.bgbb012"
            #責任中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 =  g_bgbb_m.bgbb012
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_5()
            LET g_bgbb_m.bgbb012 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb012
            NEXT FIELD bgbb012
            #END add-point
 
 
         #Ctrlp:input.c.bgbb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb013
            #add-point:ON ACTION controlp INFIELD bgbb013 name="input.c.bgbb013"
            #區域
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb013
            CALL q_oocq002_287()
            LET g_bgbb_m.bgbb013 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb013
            NEXT FIELD bgbb013
            #END add-point
 
 
         #Ctrlp:input.c.bgbb014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb014
            #add-point:ON ACTION controlp INFIELD bgbb014 name="input.c.bgbb014"
            #交易客商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb014
            CALL q_pmaa001_25()  
            LET g_bgbb_m.bgbb014 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb014
            NEXT FIELD bgbb014
            #END add-point
 
 
         #Ctrlp:input.c.bgbb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb015
            #add-point:ON ACTION controlp INFIELD bgbb015 name="input.c.bgbb015"
             #收款客商
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb015
            CALL q_pmaa001_25()  
            LET g_bgbb_m.bgbb015 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb015 ,g_bgbb_m.bgbb015_desc
            NEXT FIELD bgbb015
            #END add-point
 
 
         #Ctrlp:input.c.bgbb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb016
            #add-point:ON ACTION controlp INFIELD bgbb016 name="input.c.bgbb016"
            #客群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		      LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb016
            CALL q_oocq002_281()
            LET g_bgbb_m.bgbb016 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb016
            NEXT FIELD bgbb016
            #END add-point
 
 
         #Ctrlp:input.c.bgbb017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb017
            #add-point:ON ACTION controlp INFIELD bgbb017 name="input.c.bgbb017"
            #產品類別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
		    	LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb017
            CALL q_rtax001()
            LET g_bgbb_m.bgbb017 = g_qryparam.return1
            DISPLAY BY NAME  g_bgbb_m.bgbb017
            NEXT FIELD bgbb017
            #END add-point
 
 
         #Ctrlp:input.c.bgbb018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb018
            #add-point:ON ACTION controlp INFIELD bgbb018 name="input.c.bgbb018"
            #人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb018
            CALL q_ooag001_8()
            LET g_bgbb_m.bgbb018 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb018
            NEXT FIELD bgbb018
            #END add-point
 
 
         #Ctrlp:input.c.bgbb019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb019
            #add-point:ON ACTION controlp INFIELD bgbb019 name="input.c.bgbb019"
            #專案代號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb019
            CALL q_pjba001()
            LET g_bgbb_m.bgbb019 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb019
            NEXT FIELD bgbb019
            #END add-point
 
 
         #Ctrlp:input.c.bgbb020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb020
            #add-point:ON ACTION controlp INFIELD bgbb020 name="input.c.bgbb020"
            #WBS
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb020
            IF NOT cl_null(g_bgbb_m.bgbb019) THEN
               LET g_qryparam.where = "pjbb012='1' AND pjbb001='",g_bgbb_m.bgbb019,"'"
            ELSE
               LET g_qryparam.where = "pjbb012='1'"
            END IF
            CALL q_pjbb002()
            LET g_bgbb_m.bgbb020 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb020
            NEXT FIELD bgbb020
            #END add-point
 
 
         #Ctrlp:input.c.bgbb021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb021
            #add-point:ON ACTION controlp INFIELD bgbb021 name="input.c.bgbb021"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb022
            #add-point:ON ACTION controlp INFIELD bgbb022 name="input.c.bgbb022"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb022
            CALL q_oojd001_2()
            LET g_bgbb_m.bgbb022 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb022
            NEXT FIELD bgbb022
            #END add-point
 
 
         #Ctrlp:input.c.bgbb023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb023
            #add-point:ON ACTION controlp INFIELD bgbb023 name="input.c.bgbb023"
            #品牌
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgbb_m.bgbb023
            CALL q_oocq002_2002()
            LET g_bgbb_m.bgbb023 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb023,g_bgbb_m.bgbb023_desc
            NEXT FIELD bgbb023
            #END add-point
 
 
         #Ctrlp:input.c.bgbb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb024
            #add-point:ON ACTION controlp INFIELD bgbb024 name="input.c.bgbb024"
             #開窗i段-現金變動碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = (SELECT bgaa009 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_bgba001,"') "
            LET g_qryparam.default1 = g_bgbb_m.bgbb024
            CALL q_nmai002()
            LET g_bgbb_m.bgbb024 = g_qryparam.return1
            DISPLAY BY NAME g_bgbb_m.bgbb024
            NEXT FIELD bgbb024
            #END add-point
 
 
         #Ctrlp:input.c.bgbb025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb025
            #add-point:ON ACTION controlp INFIELD bgbb025 name="input.c.bgbb025"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb026
            #add-point:ON ACTION controlp INFIELD bgbb026 name="input.c.bgbb026"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb027
            #add-point:ON ACTION controlp INFIELD bgbb027 name="input.c.bgbb027"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb028
            #add-point:ON ACTION controlp INFIELD bgbb028 name="input.c.bgbb028"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb029
            #add-point:ON ACTION controlp INFIELD bgbb029 name="input.c.bgbb029"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb030
            #add-point:ON ACTION controlp INFIELD bgbb030 name="input.c.bgbb030"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb031
            #add-point:ON ACTION controlp INFIELD bgbb031 name="input.c.bgbb031"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb032
            #add-point:ON ACTION controlp INFIELD bgbb032 name="input.c.bgbb032"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb033
            #add-point:ON ACTION controlp INFIELD bgbb033 name="input.c.bgbb033"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgbb034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgbb034
            #add-point:ON ACTION controlp INFIELD bgbb034 name="input.c.bgbb034"
            
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
   CLOSE WINDOW w_abgt030_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE     
      RETURN g_bgbb_m_t.bgbb011,g_bgbb_m_t.bgbb012,g_bgbb_m_t.bgbb013,g_bgbb_m_t.bgbb014,g_bgbb_m_t.bgbb015, 
             g_bgbb_m_t.bgbb016,g_bgbb_m_t.bgbb017,g_bgbb_m_t.bgbb018,g_bgbb_m_t.bgbb019,g_bgbb_m_t.bgbb020,
             g_bgbb_m_t.bgbb021,g_bgbb_m_t.bgbb022,g_bgbb_m_t.bgbb023,g_bgbb_m_t.bgbb024,
             g_bgbb_m_t.bgbb025,g_bgbb_m_t.bgbb026,g_bgbb_m_t.bgbb027,g_bgbb_m_t.bgbb028,g_bgbb_m_t.bgbb029,
             g_bgbb_m_t.bgbb030,g_bgbb_m_t.bgbb031,g_bgbb_m_t.bgbb032,g_bgbb_m_t.bgbb033,g_bgbb_m_t.bgbb034
             
   END IF
   RETURN g_bgbb_m.bgbb011,g_bgbb_m.bgbb012,g_bgbb_m.bgbb013,g_bgbb_m.bgbb014,g_bgbb_m.bgbb015, 
          g_bgbb_m.bgbb016,g_bgbb_m.bgbb017,g_bgbb_m.bgbb018,g_bgbb_m.bgbb019,g_bgbb_m.bgbb020,
          g_bgbb_m.bgbb021,g_bgbb_m.bgbb022,g_bgbb_m.bgbb023,g_bgbb_m.bgbb024,
          g_bgbb_m.bgbb025,g_bgbb_m.bgbb026,g_bgbb_m.bgbb027,g_bgbb_m.bgbb028,g_bgbb_m.bgbb029,
          g_bgbb_m.bgbb030,g_bgbb_m.bgbb031,g_bgbb_m.bgbb032,g_bgbb_m.bgbb033,g_bgbb_m.bgbb034
          
   
   

   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgt030_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt030_01.other_function" readonly="Y" >}

 
{</section>}
 

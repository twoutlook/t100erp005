#該程式未解開Section, 採用最新樣板產出!
{<section id="artt409_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-07-02 21:18:45), PR版次:0002(2016-09-21 16:31:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: artt409_02
#+ Description: 
#+ Creator....: 07142(2016-07-02 21:11:15)
#+ Modifier...: 06814 -SD/PR- 08742
 
{</section>}
 
{<section id="artt409_02.global" >}
#應用 c01c 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160913-00034#5    2016/09/18   by 08742   q_pmaa001開窗改成 q_pmaa001_1 抓类型= 3，同时修改栏位控管
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
 
DEFINE g_rec_b               LIKE type_t.num10
DEFINE g_wc                  STRING
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
  PRIVATE TYPE type_g_rtel_d        RECORD
       rtelacti LIKE rtel_t.rtelacti, 
   rtelseq LIKE rtel_t.rtelseq, 
   rtel001 LIKE rtel_t.rtel001, 
   rtel023 LIKE rtel_t.rtel023, 
   rtel002 LIKE rtel_t.rtel002, 
   rtel003 LIKE rtel_t.rtel003, 
   rtell002 LIKE rtell_t.rtell002, 
   rtell003 LIKE rtell_t.rtell003, 
   rtell004 LIKE rtell_t.rtell004, 
   rtel004 LIKE rtel_t.rtel004, 
   rtel005 LIKE rtel_t.rtel005, 
   rtel006 LIKE rtel_t.rtel006, 
   rtel007 LIKE rtel_t.rtel007, 
   rtel008 LIKE rtel_t.rtel008, 
   rtel009 LIKE rtel_t.rtel009, 
   rtel010 LIKE rtel_t.rtel010, 
   rtel011 LIKE rtel_t.rtel011, 
   rtel012 LIKE rtel_t.rtel012, 
   rtel018 LIKE rtel_t.rtel018, 
   rtel020 LIKE rtel_t.rtel020, 
   rtel021 LIKE rtel_t.rtel021, 
   rtel022 LIKE rtel_t.rtel022, 
   rtel013 LIKE rtel_t.rtel013, 
   rtel014 LIKE rtel_t.rtel014, 
   rtel015 LIKE rtel_t.rtel015, 
   rtel016 LIKE rtel_t.rtel016, 
   rtel017 LIKE rtel_t.rtel017, 
   rtel019 LIKE rtel_t.rtel019
       END RECORD
DEFINE l_ac                  LIKE type_t.num10  
DEFINE g_sql                 STRING
define g_rtekdocno           like rtek_t.rtekdocno
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_rtel_d          DYNAMIC ARRAY OF type_g_rtel_d
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point  
 
{</section>}
 
{<section id="artt409_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION artt409_02(--)
   #add-point:construct段變數傳入 name="construct.get_var"
   p_rtekdocno
   #end add-point
   )
   #add-point:construct段define name="construct.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   #add-point:construct段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="construct.define"
   define p_rtekdocno  like rtek_t.rtekdocno
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_artt409_02 WITH FORM cl_ap_formpath("art","artt409_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   #輸入前處理
   #add-point:單頭前置處理 name="construct.pre_construct"
   let g_rtekdocno=p_rtekdocno
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      CONSTRUCT BY NAME g_wc ON rtdx055,rtem002 
      
            #add-point:自定義action name="construct.action"
       ON ACTION controlp INFIELD rtem002          
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i' 
               LET g_qryparam.reqry = FALSE
               #160913-00034#5 -S
               #CALL q_pmaa001()                           #呼叫開窗            
               LET g_qryparam.arg1 = "('3')"            
               CALL q_pmaa001_1()                          #呼叫開窗
               #160913-00034#5 -E                       
               DISPLAY g_qryparam.return1 TO rtem002
               NEXT FIELD rtem002  
      ON ACTION controlp INFIELD rtdx055
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i' 
               LET g_qryparam.reqry = FALSE
               CALL q_mhbc001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtdx055  #顯示到畫面上
               NEXT FIELD rtdx055
            #end add-point
      
         BEFORE CONSTRUCT
            #add-point:單頭輸入前處理 name="construct.before_construct"
            
            #end add-point
            
         AFTER CONSTRUCT
            #add-point:單頭輸入後處理 name="construct.after_construct"
            
            #end add-point
            
         
 
         
       
      END CONSTRUCT
 
      #add-point:自定義construct name="construct.more_construct"
 
      #end add-point
      
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
 
   #add-point:畫面關閉前 name="construct.before_close"
 
   #end add-point 
   
   #畫面關閉
   CLOSE WINDOW w_artt409_02 
   
   #add-point:construct段after construct name="construct.post_construct"
  IF INT_FLAG = 1 THEN
      LET INT_FLAG = TRUE 
      RETURN
   ELSE
       call artt409_02_query()
      RETURN
   END IF
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="artt409_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="artt409_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION artt409_02_query()
DEFINE l_rtellseq  LIKE rtell_t.rtellseq
DEFINE l_rtelseq  LIKE rtel_t.rtelseq
DEFINE l_t        INT 
LET l_t=0

  SELECT MAX(rtellseq) INTO l_rtellseq FROM rtell_t WHERE rtellent=g_enterprise AND rtelldocno=g_rtekdocno
  IF cl_null(l_rtellseq) THEN
  	 LET l_rtellseq=0
  END IF
  SELECT MAX(rtelseq) INTO l_rtelseq FROM rtel_t WHERE rtelent=g_enterprise AND rteldocno=g_rtekdocno
  IF cl_null(l_rtelseq) THEN
  	 LET l_rtelseq=0
  END IF  
  LET l_ac=1  
  LET g_sql ="SELECT 'Y' ,imaa100,imaa109,rtdx002,rtdx001,",
              "      (SELECT imaal003 FROM imaal_t  ",
               "        WHERE imaalent = rtdxent AND imaal001 = rtdx001 AND imaal002 = '",g_dlang,"') imaal003, ",
               "      (SELECT imaal004 FROM imaal_t ",
               "        WHERE imaalent = rtdxent AND imaal001 = rtdx001 AND imaal002 = '",g_dlang,"') imaal004, ",
               "      (SELECT imaal005 FROM imaal_t ",
               "        WHERE imaalent = rtdxent AND imaal001 = rtdx001 AND imaal002 = '",g_dlang,"') imaal005, ",
               "    imaf112,",
               "    imaa122,rtdx012,imaa009,imaa126,imaa127,imaa128,imaa129,",
               "   rtdx056,rtdx057,rtdx058,rtdx059,rtdx060,rtdx034,rtdx016,rtdx017,rtdx018,rtdx019,rtdx044" ,             
               "  FROM rtdx_t,imaa_t ",   
               "              LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 AND rtaw003 = '",cl_get_para(g_enterprise,g_site,'E-CIR-0001'),"' ",
               "       ,imaf_t,rtem_t ",  
               " WHERE rtdxent  = imaaent ",
               "   AND rtdx001  = imaa001 ",
               "   AND rtdxent  = imafent ",                       
               "   AND rtdxsite = imafsite ",                      
               "   AND rtdx001  = imaf001 ",                       
               "   AND rtdxent  = rtement ",                      
               "   AND rtdxsite = rtemsite ",                   
               "   AND rtdx055  = rtem001 ",                   
               "   AND rtdx001  = rtem003 ",                  
               "   AND imaf153  = rtem002 ",            
               "   AND rtdxent= ? AND 1=1 AND ", g_wc
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq409_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artq409_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtel_d[l_ac].rtelacti,g_rtel_d[l_ac].rtel001, 
                      g_rtel_d[l_ac].rtel023,g_rtel_d[l_ac].rtel002,g_rtel_d[l_ac].rtel003,g_rtel_d[l_ac].rtell002,
                      g_rtel_d[l_ac].rtell003,g_rtel_d[l_ac].rtell004,g_rtel_d[l_ac].rtel004, 
                      g_rtel_d[l_ac].rtel005,g_rtel_d[l_ac].rtel006,g_rtel_d[l_ac].rtel007,g_rtel_d[l_ac].rtel008, 
                      g_rtel_d[l_ac].rtel009,g_rtel_d[l_ac].rtel010,g_rtel_d[l_ac].rtel011,g_rtel_d[l_ac].rtel012, 
                      g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel020,g_rtel_d[l_ac].rtel021,g_rtel_d[l_ac].rtel022, 
                      g_rtel_d[l_ac].rtel013,g_rtel_d[l_ac].rtel014,g_rtel_d[l_ac].rtel015,g_rtel_d[l_ac].rtel016, 
                      g_rtel_d[l_ac].rtel017,g_rtel_d[l_ac].rtel019
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #LET g_rtel_d[l_ac].rtelseq=l_ac
      SELECT count(*) INTO l_t FROM rtel_t 
      WHERE rtelent=g_enterprise AND rteldocno=g_rtekdocno AND rtel002=g_rtel_d[l_ac].rtel002
      IF l_t=0 THEN 
         LET l_rtellseq=l_rtellseq+1
         LET l_rtelseq=l_rtelseq+1
         INSERT INTO rtel_t
                     (rtelent,rteldocno,rtelseq,rtelacti,rtel001,
                     rtel023,rtel002,rtel003,rtel004,rtel005,
                     rtel006,rtel007,rtel008,rtel009,rtel010,
                     rtel011,rtel012,rtel018,rtel020,rtel021,
                     rtel022,rtel013,rtel014,rtel015,rtel016,
                     rtel017,rtel019) 
               VALUES(g_enterprise,g_rtekdocno,l_rtelseq,g_rtel_d[l_ac].rtelacti,g_rtel_d[l_ac].rtel001,
                      g_rtel_d[l_ac].rtel023, g_rtel_d[l_ac].rtel002,g_rtel_d[l_ac].rtel003,g_rtel_d[l_ac].rtel004,g_rtel_d[l_ac].rtel005,
                      g_rtel_d[l_ac].rtel006,g_rtel_d[l_ac].rtel007,g_rtel_d[l_ac].rtel008,g_rtel_d[l_ac].rtel009,g_rtel_d[l_ac].rtel010, 
                      g_rtel_d[l_ac].rtel011,g_rtel_d[l_ac].rtel012,g_rtel_d[l_ac].rtel018,g_rtel_d[l_ac].rtel020,g_rtel_d[l_ac].rtel021,
                      g_rtel_d[l_ac].rtel022,g_rtel_d[l_ac].rtel013,g_rtel_d[l_ac].rtel014,g_rtel_d[l_ac].rtel015,g_rtel_d[l_ac].rtel016,
                      g_rtel_d[l_ac].rtel017,g_rtel_d[l_ac].rtel019) 
             INSERT INTO rtell_t (rtellent,rtelldocno,rtellseq,rtell001,rtell002,rtell003,rtell004)
             VALUES (g_enterprise,g_rtekdocno,l_rtellseq,g_dlang,g_rtel_d[l_ac].rtell002,g_rtel_d[l_ac].rtell003,g_rtel_d[l_ac].rtell004)
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend =  "" 
               LET g_errparam.code   =  9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
         
            END IF
            EXIT FOREACH
         END IF
         LET l_ac = l_ac + 1
      ELSE
         CONTINUE FOREACH
      END IF 
 
   END FOREACH
END FUNCTION

 
{</section>}
 

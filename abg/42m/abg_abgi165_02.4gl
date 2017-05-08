#該程式未解開Section, 採用最新樣板產出!
{<section id="abgi165_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-12-13 11:47:26), PR版次:0005(2017-01-24 17:19:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgi165_02
#+ Description: 預算組織料件批次產生
#+ Creator....: 06821(2016-08-08 11:54:11)
#+ Modifier...: 06821 -SD/PR- 06821
 
{</section>}
 
{<section id="abgi165_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161006-00005#43  2016/11/22  By 08732    組織類型與職能開窗調整
#161129-00019#5   2016/12/13  By 06821    1.抛轉到據點時, 對應料件若存在於 aimm211才可寫入 2.預算組織對應料件處理原則 3.增加一個選項:資料已存在直接覆蓋 4.修正組織類型與職能開窗調整調整錯誤 5.增加處理161129-00019#3 3.abgi165_02 預算組織料批次產生時, 控管實體料只能對應一筆預算料,若對應料件已存在,則對應料件不寫入
#170123-00045#2   2017/01/24  By 06821    SQL中撈取資料時使用 rownum 語法撰寫方式調整
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
PRIVATE type type_g_bgea_m        RECORD
       bgea001 LIKE bgea_t.bgea001, 
   bgea001_desc LIKE type_t.chr80, 
   l_cover LIKE type_t.chr1, 
   bgas003 LIKE type_t.chr10, 
   bgas001 LIKE type_t.chr500, 
   bgas005 LIKE type_t.chr10, 
   bgas004 LIKE type_t.chr10
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc         STRING
DEFINE g_wc_bgas003 STRING
#end add-point
 
DEFINE g_bgea_m        type_g_bgea_m
 
   DEFINE g_bgea001_t LIKE bgea_t.bgea001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgi165_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgi165_02(--)
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
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_n             LIKE type_t.num10
   DEFINE r_success       LIKE type_t.num5
   DEFINE g_wc_cs_comp    STRING   #161006-00005#43  add  在azzi800權限中的法人
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgi165_02 WITH FORM cl_ap_formpath("abg","abgi165_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CLEAR FORM
   WHENEVER ERROR CONTINUE
   
   INITIALIZE g_bgea_m.* TO NULL
   
   CALL cl_set_combo_scc('bgas005','1001')
   CALL s_fin_create_account_center_tmp()
   
   #161006-00005#43   add---s                     
   CALL s_fin_azzi800_sons_query(g_today)                      
   CALL s_fin_account_center_sons_str() RETURNING g_wc_cs_comp 
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp  
   #161006-00005#43   add---e
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgea_m.bgea001,g_bgea_m.l_cover ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_bgea_m.l_cover = 'N'
            DISPLAY BY NAME g_bgea_m.l_cover
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgea001
            
            #add-point:AFTER FIELD bgea001 name="input.a.bgea001"
            LET g_bgea_m.bgea001_desc = ' '
            DISPLAY BY NAME g_bgea_m.bgea001_desc
            IF NOT cl_null(g_bgea_m.bgea001) THEN
               CALL s_fin_budget_chk(g_bgea_m.bgea001)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success  THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] = 'abgi040'
                  LET g_errparam.replace[2] = cl_get_progname('abgi040',g_lang,"2")
                  LET g_errparam.exeprog = 'abgi040'
                  CALL cl_err()
                  LET g_bgea_m.bgea001 = ''
                  LET g_bgea_m.bgea001_desc = s_desc_get_budget_desc(g_bgea_m.bgea001)
                  DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_fin_abg_center_sons_query(g_bgea_m.bgea001,'','')   
            END IF
            LET g_bgea_m.bgea001_desc = s_desc_get_budget_desc(g_bgea_m.bgea001)
            DISPLAY BY NAME g_bgea_m.bgea001,g_bgea_m.bgea001_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgea001
            #add-point:BEFORE FIELD bgea001 name="input.b.bgea001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgea001
            #add-point:ON CHANGE bgea001 name="input.g.bgea001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_cover
            #add-point:BEFORE FIELD l_cover name="input.b.l_cover"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_cover
            
            #add-point:AFTER FIELD l_cover name="input.a.l_cover"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_cover
            #add-point:ON CHANGE l_cover name="input.g.l_cover"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgea001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgea001
            #add-point:ON ACTION controlp INFIELD bgea001 name="input.c.bgea001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_bgea_m.bgea001
            LET g_qryparam.where = "bgaastus = 'Y'"
            CALL q_bgaa001()
            LET g_bgea_m.bgea001 = g_qryparam.return1
            DISPLAY BY NAME g_bgea_m.bgea001
            NEXT FIELD bgea001    #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.l_cover
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_cover
            #add-point:ON ACTION controlp INFIELD l_cover name="input.c.l_cover"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON bgas001,bgas005,bgas004
      
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD bgas001
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   
            LET g_qryparam.state = 'c'       
            LET g_qryparam.reqry = FALSE
            CALL q_bgas001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgas001  #顯示到畫面上
            NEXT FIELD bgas001                     #返回原欄位
         
         
         ON ACTION controlp INFIELD bgas005
       
         ON ACTION controlp INFIELD bgas004
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgas004  #顯示到畫面上
            NEXT FIELD bgas004                     #返回原欄位

      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc_bgas003 ON bgas003
      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD bgas003
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL   
            LET g_qryparam.state = 'c'  
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooef205 = 'Y' AND ooef001 IN (SELECT ooef001 FROM s_fin_tmp1 ) AND ooefstus = 'Y'"   #161006-00005#43   mark
            #161129-00019#5 --s mark
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp   #161006-00005#43   add 
            #CALL q_ooef001()                           #呼叫開窗
            #161129-00019#5 --e mark
            #161129-00019#5 --s add 
            LET g_qryparam.where = " ooef001 IN (SELECT ooef001 FROM s_fin_tmp1 ) AND ooefstus = 'Y'" 
            CALL q_ooef001_77()                             
            #161129-00019#5 --e add 
            DISPLAY g_qryparam.return1 TO bgas003      #顯示到畫面上
            NEXT FIELD bgas003  

      END CONSTRUCT
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
   CLOSE WINDOW w_abgi165_02 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   
   CALL cl_err_collect_init()
   IF INT_FLAG THEN
      LET r_success= FALSE
      LET INT_FLAG = 0
   ELSE
      CALL abgi165_02_ins_bgea() RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success= FALSE
      END IF
   END IF
   CALL cl_err_collect_show()
   
   RETURN r_success 
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgi165_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgi165_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 寫入預算組織料件維護(abgi170)
# Memo...........:
# Usage..........: CALL abgi165_02_ins_bgea()
# Date & Author..: 160809 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgi165_02_ins_bgea()
DEFINE ld_date       DATETIME YEAR TO SECOND
DEFINE l_sql         STRING      
DEFINE l_sql_bgea002 STRING      
DEFINE l_cnt         LIKE type_t.num10   
DEFINE l_cntdo       LIKE type_t.num10        #實際執行筆數
DEFINE l_bgea002     LIKE bgea_t.bgea002      #有權限組織
DEFINE l_bgea        RECORD                   #主table
         bgeaent     LIKE bgea_t.bgeaent,	    #企業編號
         bgea001     LIKE bgea_t.bgea001,	    #預算編號
         bgea002     LIKE bgea_t.bgea002,	    #預算組織
         bgea003     LIKE bgea_t.bgea003,	    #預算料號
         bgea004     LIKE bgea_t.bgea004,	    #對應銷售預算細項
         bgea005     LIKE bgea_t.bgea005,	    #對應採購預算細項
         bgea006     LIKE bgea_t.bgea006,	    #對應成本預算細項
         bgea009     LIKE bgea_t.bgea009,	    #銷售分群
         bgea010     LIKE bgea_t.bgea010,	    #銷售單位
         bgea011     LIKE bgea_t.bgea011,	    #主要客戶
         bgea012     LIKE bgea_t.bgea012,	    #銷售稅別
         bgea013     LIKE bgea_t.bgea013,	    #銷售幣別
         bgea014     LIKE bgea_t.bgea014,	    #標準售價
         bgea015     LIKE bgea_t.bgea015,	    #採購分群
         bgea016     LIKE bgea_t.bgea016,	    #採購單位
         bgea017     LIKE bgea_t.bgea017,	    #主供應商
         bgea018     LIKE bgea_t.bgea018,	    #採購稅別
         bgea019     LIKE bgea_t.bgea019,	    #標準採購幣別
         bgea020     LIKE bgea_t.bgea020,	    #標準採購單價
         bgea021     LIKE bgea_t.bgea021,	    #最小採購量
         bgea022     LIKE bgea_t.bgea022,	    #M件採購比率
         bgea023     LIKE bgea_t.bgea023,	    #內採比率
         bgea024     LIKE bgea_t.bgea024,	    #採購損耗率
         bgea025     LIKE bgea_t.bgea025,	    #生產單位
         bgea026     LIKE bgea_t.bgea026,	    #庫存單位
         bgea027     LIKE bgea_t.bgea027,	    #發料單位
         bgea028     LIKE bgea_t.bgea028,	    #安全庫存量
         bgea029     LIKE bgea_t.bgea029,	    #生產提前比率
         bgea030     LIKE bgea_t.bgea030,	    #生產損耗率
         bgea031     LIKE bgea_t.bgea031,	    #成本分群
         bgea032     LIKE bgea_t.bgea032,	    #預計成本階數
         bgea033     LIKE bgea_t.bgea033,	    #低階碼
         bgea034     LIKE bgea_t.bgea034,	    #標準工時
         bgea035     LIKE bgea_t.bgea035,	    #標準機時
         bgea036     LIKE bgea_t.bgea036,	    #標準單位材料成本
         bgea037     LIKE bgea_t.bgea037,	    #標準單位人工成本
         bgea038     LIKE bgea_t.bgea038,	    #標準單位委外加工費
         bgea039     LIKE bgea_t.bgea039,	    #標準單位製造費用一
         bgea040     LIKE bgea_t.bgea040,	    #標準單位製造費用二
         bgea041     LIKE bgea_t.bgea041,	    #標準單位製造費用三
         bgea042     LIKE bgea_t.bgea042,	    #標準單位製造費用四
         bgea043     LIKE bgea_t.bgea043,	    #標準單位製造費用五
         bgea044     LIKE bgea_t.bgea044,	    #成本幣別
         bgeastus	   LIKE bgea_t.bgeastus,	 #狀態碼
         bgeaownid   LIKE bgea_t.bgeaownid, 	 #資料所有者
         bgeaowndp   LIKE bgea_t.bgeaowndp, 	 #資料所屬部門
         bgeacrtid   LIKE bgea_t.bgeacrtid, 	 #資料建立者
         bgeacrtdp   LIKE bgea_t.bgeacrtdp, 	 #資料建立部門
         bgeacrtdt   LIKE bgea_t.bgeacrtdt, 	 #資料創建日
         bgeamodid   LIKE bgea_t.bgeamodid, 	 #資料修改者
         bgeamoddt   LIKE bgea_t.bgeamoddt 	 #最近修改日
                     END RECORD             
DEFINE l_bgas        RECORD                   #來源table
         bgasent	   LIKE bgas_t.bgasent,	    #企業編號
         bgas001	   LIKE bgas_t.bgas001,	    #預算料號
         bgas002	   LIKE bgas_t.bgas002,	    #參考料號
         bgas003	   LIKE bgas_t.bgas003,	    #進銷存/成本參考據點
         bgas004	   LIKE bgas_t.bgas004,	    #主分群碼
         bgas005	   LIKE bgas_t.bgas005,	    #料件類別
         bgas006	   LIKE bgas_t.bgas006,	    #產品特徵組別
         bgas008	   LIKE bgas_t.bgas008,	    #基礎單位
         bgas110	   LIKE bgas_t.bgas110,	    #銷售分群
         bgas111	   LIKE bgas_t.bgas111,	    #銷售單位
         bgas112	   LIKE bgas_t.bgas112,	    #主要客戶
         bgas113	   LIKE bgas_t.bgas113,	    #銷售稅別
         bgas114	   LIKE bgas_t.bgas114,	    #銷售幣別
         bgas115	   LIKE bgas_t.bgas115,	    #標準售價
         bgas210	   LIKE bgas_t.bgas210,	    #採購分群
         bgas211	   LIKE bgas_t.bgas211,	    #採購單位
         bgas212	   LIKE bgas_t.bgas212,	    #主供應商
         bgas213	   LIKE bgas_t.bgas213,	    #採購稅別
         bgas214	   LIKE bgas_t.bgas214,	    #標準採購幣別
         bgas215	   LIKE bgas_t.bgas215,	    #標準採購單價
         bgas216	   LIKE bgas_t.bgas216,	    #最小採購量
         bgas217	   LIKE bgas_t.bgas217,	    #M件採購比率
         bgas218	   LIKE bgas_t.bgas218,	    #內採比率
         bgas219	   LIKE bgas_t.bgas219,	    #採購損耗率
         bgas310	   LIKE bgas_t.bgas310,	    #生產單位
         bgas311	   LIKE bgas_t.bgas311,	    #庫存單位
         bgas312	   LIKE bgas_t.bgas312,	    #發料單位
         bgas313	   LIKE bgas_t.bgas313,	    #安全庫存量
         bgas314	   LIKE bgas_t.bgas314,	    #生產提前比率
         bgas315	   LIKE bgas_t.bgas315,	    #生產損耗率
         bgas410	   LIKE bgas_t.bgas410,	    #成本分群
         bgas411	   LIKE bgas_t.bgas411,	    #預計成本階數
         bgas412	   LIKE bgas_t.bgas412,	    #低階碼
         bgas413	   LIKE bgas_t.bgas413,	    #成本幣別
         bgas414	   LIKE bgas_t.bgas414,	    #標準工時
         bgas415	   LIKE bgas_t.bgas415,	    #標準機時
         bgas416	   LIKE bgas_t.bgas416,	    #標準單位材料成本
         bgas417	   LIKE bgas_t.bgas417,	    #標準單位人工成本
         bgas418	   LIKE bgas_t.bgas418,	    #標準單位委外加工費
         bgas419	   LIKE bgas_t.bgas419,	    #標準單位製造費用一
         bgas420	   LIKE bgas_t.bgas420,	    #標準單位製造費用二
         bgas421	   LIKE bgas_t.bgas421,	    #標準單位製造費用三
         bgas422	   LIKE bgas_t.bgas422,	    #標準單位製造費用四
         bgas423	   LIKE bgas_t.bgas423	    #標準單位製造費用五
                     END RECORD  
DEFINE l_bgeb        RECORD                   #預算組織料號對應檔
         bgebent     LIKE bgeb_t.bgebent,     #企業編號
         bgeb001     LIKE bgeb_t.bgeb001,     #預算編號
         bgeb002     LIKE bgeb_t.bgeb002,     #預算組織
         bgeb003     LIKE bgeb_t.bgeb003,     #預算料號
         bgeb004     LIKE bgeb_t.bgeb004,     #對應料號
         bgebownid   LIKE bgeb_t.bgebownid,   #資料所有者
         bgebowndp   LIKE bgeb_t.bgebowndp,   #資料所屬部門
         bgebcrtid   LIKE bgeb_t.bgebcrtid,   #資料建立者
         bgebcrtdp   LIKE bgeb_t.bgebcrtdp,   #資料建立部門
         bgebcrtdt   LIKE bgeb_t.bgebcrtdt,   #資料創建日
         bgebmodid   LIKE bgeb_t.bgebmodid,   #資料修改者
         bgebmoddt   LIKE bgeb_t.bgebmoddt,   #最近修改日
         bgebstus    LIKE bgeb_t.bgebstus     #狀態碼
                     END RECORD    
#161129-00019#5 --s add                     
DEFINE l_imaa        RECORD    
         imaa001     LIKE imaa_t.imaa001,
         imaa003     LIKE imaa_t.imaa003,
         imaa004     LIKE imaa_t.imaa004,
         imaa005     LIKE imaa_t.imaa005,
         imaa006     LIKE imaa_t.imaa006
                     END RECORD
DEFINE l_imaf        RECORD    
         imaf111     LIKE imaf_t.imaf111,
         imaf112     LIKE imaf_t.imaf112,
         imaf017     LIKE imaf_t.imaf017,
         imaf141     LIKE imaf_t.imaf141,
         imaf143     LIKE imaf_t.imaf143, 
         imaf153     LIKE imaf_t.imaf153,
         imaf146     LIKE imaf_t.imaf146,
         imaf164     LIKE imaf_t.imaf164,
         imaf053     LIKE imaf_t.imaf053,
         imaf026     LIKE imaf_t.imaf026
                     END RECORD
DEFINE l_bgas002     LIKE bgas_t.bgas002      
DEFINE l_bgat002     LIKE bgat_t.bgat002  
DEFINE l_ooef016     LIKE ooef_t.ooef016  
DEFINE l_ooef017     LIKE ooef_t.ooef017  
DEFINE l_bgeb_do     LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE l_errno       LIKE gzze_t.gzze001
#161129-00019#5 --e add  
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   WHENEVER ERROR CONTINUE
   
   IF cl_null(g_wc) THEN LET g_wc = " 1=1" END IF
   IF cl_null(g_wc_bgas003) THEN LET g_wc_bgas003 = " 1=1" END IF
   LET g_wc_bgas003 = cl_replace_str(g_wc_bgas003,"bgas003","ooef001")
   
   LET ld_date = cl_get_current()  
   LET l_cntdo = 0   

   #161129-00019#5 --s add
   #檢查是否已存在abgi170
   LET l_sql = " SELECT COUNT(1) ",
               "   FROM bgea_t ",
               "  WHERE bgeaent = ",g_enterprise,
               "    AND bgea001 = '",g_bgea_m.bgea001,"' ",               
               "    AND bgea002 = ? ",               
               "    AND bgea003 = ? "
   PREPARE abgi165_02_cnt_p FROM l_sql
   
   #撈出abgi165該筆資料中,存在料件據點進銷存檔中的料號
   LET l_sql = "SELECT UNIQUE bgat002 FROM bgat_t ",
               " WHERE bgatent = ",g_enterprise," AND bgat001 = ? ",
               "   AND bgat002 IN (SELECT imaf001 FROM imaf_t WHERE imafent = ",g_enterprise," AND imafsite = ? ) ",
               " ORDER BY bgat002 "
   PREPARE abgi165_02_bgat002_p FROM l_sql
   DECLARE abgi165_02_bgat002_c CURSOR FOR abgi165_02_bgat002_p 
   
   #預算料件是否存在料件據點進銷存檔中的料號
   LET l_sql = "SELECT COUNT(1) FROM imaf_t ",
               " WHERE imafent = ",g_enterprise,
               "   AND imafsite = ? ", 
               "   AND imaf001 = ? "
   PREPARE abgi165_02_cnt_INimaf_p FROM l_sql
   
   #撈出據點級料件資訊
   LET l_sql = " SELECT DISTINCT imaa001,imaa003,imaa004,imaa005,imaa006, ",
               "                 imaf111,imaf112,imaf017,imaf141,imaf143, ",
               "                 imaf153,imaf146,imaf164,imaf053,imaf026 ",
               "   FROM imaf_t,imaa_t ",
               "  WHERE imafent = ",g_enterprise,
               "    AND imafsite = ? ",
               "    AND imaf001 = ? ",
               "    AND imafent = imaaent AND imaf001 = imaa001 ",            
               "  ORDER BY imaa001 "
               
   PREPARE abgi165_01_imaf_p FROM l_sql
   #161129-00019#5 --e add 

   #161129-00019#5 --s mark 已存在資料改用flag判斷,不用詢問
   ##檢查若已有資料存在,是否重新產生_是:刪除後產生 / 否:取消執行
   #LET l_cnt = 0
   #SELECT COUNT(*) INTO l_cnt 
   #  FROM bgea_t 
   # WHERE bgeaent = g_enterprise 
   #   AND bgea001 = g_bgea_m.bgea001
   #
   #IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   #
   #IF l_cnt > 0 THEN
   #   IF NOT cl_ask_confirm("ais-00196") THEN
   #      LET r_success = FALSE
   #      RETURN r_success
   #   END IF
   #END IF 
   #
   ##預算組織料件主檔_因可重覆執行,寫入前先刪除資料
   #DELETE FROM bgea_t 
   # WHERE bgeaent = g_enterprise 
   #   AND bgea001 = g_bgea_m.bgea001
   #
   ##預算組織料號對應檔_因可重覆執行,寫入前先刪除資料
   #DELETE FROM bgeb_t 
   # WHERE bgebent = g_enterprise 
   #   AND bgeb001 = g_bgea_m.bgea001
   #   
   ##預算組織料件內採對應檔_因可重覆執行,寫入前先刪除資料
   #DELETE FROM bgec_t 
   # WHERE bgecent = g_enterprise 
   #   AND bgec001 = g_bgea_m.bgea001
   #161129-00019#5 --e mark
 
   #撈出據點級料件資訊
   LET l_sql = " SELECT DISTINCT bgasent,bgas001,bgas002,bgas003,bgas004, ",
               "                 bgas005,bgas006,bgas008,bgas110,bgas111, ",	 
               "                 bgas112,bgas113,bgas114,bgas115,bgas210, ",	 
               "                 bgas211,bgas212,bgas213,bgas214,bgas215, ",	 
               "                 bgas216,bgas217,bgas218,bgas219,bgas310, ",	 
               "                 bgas311,bgas312,bgas313,bgas314,bgas315, ",
               "                 bgas410,bgas411,bgas412,bgas413,bgas414, ",	 
               "                 bgas415,bgas416,bgas417,bgas418,bgas419, ",	 
               "                 bgas420,bgas421,bgas422,bgas423 ",
               "   FROM bgas_t ",
               "  WHERE bgasent = ",g_enterprise,
               "    AND ",g_wc,               
               "  ORDER BY bgas001 "
   PREPARE abgi165_02_p FROM l_sql
   DECLARE abgi165_02_c CURSOR FOR abgi165_02_p 
 
   #組織權限判斷
   LET l_bgea002 = ''
   LET l_sql_bgea002 = " SELECT DISTINCT ooef001 FROM ooef_t ",
                       "  WHERE ooefent = ",g_enterprise," AND ooef205 = 'Y' ",
                       "    AND ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) AND ooefstus = 'Y' ",
                       "    AND ",g_wc_bgas003,
                       "  ORDER BY ooef001 "
   PREPARE abgi165_02_bgea002_p FROM l_sql_bgea002
   DECLARE abgi165_02_bgea002_c CURSOR FOR abgi165_02_bgea002_p
   FOREACH abgi165_02_bgea002_c INTO l_bgea002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:abgi165_02_bgea002_c"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF 
      
      #撈出據點級料件資訊
      INITIALIZE l_bgas.* TO NULL
      FOREACH abgi165_02_c INTO l_bgas.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:abgi165_02_bgea002_c"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF 
         
         #161129-00019#5 --s add
         INITIALIZE l_bgea.* TO NULL
         #寫入前,檢核該預算料件是否存在imaf料件據點進銷存檔
         LET l_cnt = 0
         EXECUTE abgi165_02_cnt_INimaf_p USING l_bgea002,l_bgas.bgas001 INTO l_cnt
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
        
         #如有資料存在: 
         IF l_cnt > 0 THEN
            LET l_bgas002 = ''
            IF NOT cl_null(l_bgas.bgas002) THEN
               LET l_bgas002 = l_bgas.bgas002
            ELSE
               #若參考料件空,則取對應料件中第一筆存在imaf的資料
               LET l_bgat002 = ''
               FOREACH abgi165_02_bgat002_c USING l_bgas.bgas001,l_bgea002 INTO l_bgat002
                  LET l_bgas002 = l_bgat002
                  EXIT FOREACH
               END FOREACH               
            END IF       
            IF NOT cl_null(l_bgas002) THEN
               #若參考料件不為空,則取料件+據點(site = '預算組織)資料
               EXECUTE abgi165_01_imaf_p USING l_bgea002,l_bgas002 INTO l_imaa.*,l_imaf.* 
               LET l_ooef016 = ''
               LET l_ooef017 = ''
               SELECT ooef016,ooef017 INTO l_ooef016,l_ooef017
                 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = l_bgea002
                
               LET l_bgea.bgeaent   = g_enterprise
               LET l_bgea.bgea001   = g_bgea_m.bgea001
               LET l_bgea.bgea002   = l_bgea002
               LET l_bgea.bgea003   = l_bgas.bgas001
               LET l_bgea.bgea004   = ''
               LET l_bgea.bgea005   = ''
               LET l_bgea.bgea006   = ''
               LET l_bgea.bgea009   = l_imaf.imaf111
               LET l_bgea.bgea010   = l_imaf.imaf112
               LET l_bgea.bgea011   = ''
               LET l_bgea.bgea012   = l_imaf.imaf017
               LET l_bgea.bgea013   = l_ooef016
               #標準售價/採購單價
               SELECT imai223,imai023 INTO l_bgea.bgea014,l_bgea.bgea020
                 FROM imai_t
                WHERE imaient = g_enterprise AND imaisite = l_bgea002 AND imai001 = l_bgas002  
                
               LET l_bgea.bgea015   = l_imaf.imaf141
               LET l_bgea.bgea016   = l_imaf.imaf143
               LET l_bgea.bgea017   = l_imaf.imaf153
               LET l_bgea.bgea018   = l_imaf.imaf017
               LET l_bgea.bgea019   = l_ooef016
               LET l_bgea.bgea021   = l_imaf.imaf146
               LET l_bgea.bgea022   = 0
               LET l_bgea.bgea023   = 0
               LET l_bgea.bgea024   = l_imaf.imaf164
               
               #生產單位/發料單位/生產損耗率
               SELECT imae016,imae081,imae015 INTO l_bgea.bgea025,l_bgea.bgea027,l_bgea.bgea030
                 FROM imae_t
                WHERE imaeent = g_enterprise AND imaesite = l_bgea002 AND imae001 = l_bgas002
                
               LET l_bgea.bgea026   = l_imaf.imaf053
               LET l_bgea.bgea028   = l_imaf.imaf026
               LET l_bgea.bgea029   = 0
               
               #成本分群/標準單位工時/標準單位機時
               SELECT imag011,imag016,imag017 INTO l_bgea.bgea031,l_bgea.bgea034,l_bgea.bgea035
                 FROM imag_t
                WHERE imagent = g_enterprise AND imagsite = l_bgea002 AND imag001 = l_bgas002
               
               #預計成本階數/低階碼
               #170123-00045#2 --s mark
               #SELECT xcbb006,xcbb007 INTO l_bgea.bgea032,l_bgea.bgea033
               #  FROM xcbb_t
               # WHERE xcbbent = g_enterprise 
               #   AND xcbbcomp = l_ooef017
               #   AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t 
               #                   WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas002 AND xcbbcomp = l_ooef017)
               #   AND xcbb002 = (SELECT MAX(xcbb002) FROM xcbb_t 
               #                   WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas002 AND xcbbcomp = l_ooef017 
               #                     AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t 
               #                                     WHERE xcbbent = g_enterprise AND xcbb003 = l_bgas002 
               #                                       AND xcbbcomp = l_ooef017))
               #   AND xcbb003 = l_bgas002 AND rownum = '1'
               #170123-00045#2 --e mark
               
               #170123-00045#2 --s add
               LET l_sql = " SELECT xcbb006,xcbb007 ",
                           "   FROM xcbb_t ",
                           "  WHERE xcbbent = ",g_enterprise,"  ",
                           "    AND xcbbcomp = '",l_ooef017,"'  ",
                           "    AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t  ",
                           "                    WHERE xcbbent = ",g_enterprise," AND xcbb003 = '",l_bgas002,"' AND xcbbcomp = '",l_ooef017,"' ) ",
                           "    AND xcbb002 = (SELECT MAX(xcbb002) FROM xcbb_t  ",
                           "                    WHERE xcbbent = ",g_enterprise," AND xcbb003 = '",l_bgas002,"' AND xcbbcomp = '",l_ooef017,"'   ",
                           "                      AND xcbb001 = (SELECT MAX(xcbb001) FROM xcbb_t  ",
                           "                                      WHERE xcbbent = ",g_enterprise," AND xcbb003 = '",l_bgas002,"'  ",
                           "                                        AND xcbbcomp = '",l_ooef017,"' ))  ",
                           "    AND xcbb003 = '",l_bgas002,"'  "
               PREPARE abgi165_02_xcbb_p FROM l_sql
               DECLARE abgi165_02_xcbb_c SCROLL CURSOR FOR abgi165_02_xcbb_p               
               OPEN abgi165_02_xcbb_c
               FETCH FIRST abgi165_02_xcbb_c INTO l_bgea.bgea032,l_bgea.bgea033
               CLOSE abgi165_02_xcbb_c        
               #170123-00045#2 --e add                     
               
               LET l_bgea.bgea044	= l_ooef016
               
               #單位成本-材料/單位成本-人工/單位成本-委外/單位成本-制費一/
               #單位成本-制費二/單位成本-制費三/單位成本-制費四/單位成本-制費五
               SELECT xcag102a,xcag102b,xcag102c,xcag102d,
                      xcag102e,xcag102f,xcag102g,xcag102h
                 INTO l_bgea.bgea036,l_bgea.bgea037,l_bgea.bgea038,l_bgea.bgea039,
                      l_bgea.bgea040,l_bgea.bgea041,l_bgea.bgea042,l_bgea.bgea043
                 FROM xcag_t
                WHERE xcagent = g_enterprise AND xcagsite = l_bgea002
                  AND xcag001 = l_bgea.bgea031
                  AND xcag002 <= g_today
                  AND (xcag003 IS NULL OR xcag003 >= g_today)
                  AND xcag004 = l_bgas002    
            ELSE
               LET l_bgea.bgeaent   = g_enterprise
               LET l_bgea.bgea001   = g_bgea_m.bgea001
               LET l_bgea.bgea002   = l_bgea002
               LET l_bgea.bgea003   = l_bgas.bgas001
               LET l_bgea.bgea004   = ''
               LET l_bgea.bgea005   = ''
               LET l_bgea.bgea006   = ''
               LET l_bgea.bgea009   = l_bgas.bgas110
               LET l_bgea.bgea010   = l_bgas.bgas111
               LET l_bgea.bgea011   = l_bgas.bgas112
               LET l_bgea.bgea012   = l_bgas.bgas113
               LET l_bgea.bgea013   = l_bgas.bgas114
               LET l_bgea.bgea014   = l_bgas.bgas115
               LET l_bgea.bgea015   = l_bgas.bgas210
               LET l_bgea.bgea016   = l_bgas.bgas211
               LET l_bgea.bgea017   = l_bgas.bgas212
               LET l_bgea.bgea018   = l_bgas.bgas213
               LET l_bgea.bgea019   = l_bgas.bgas214
               LET l_bgea.bgea020   = l_bgas.bgas215
               LET l_bgea.bgea021   = l_bgas.bgas216
               LET l_bgea.bgea022   = l_bgas.bgas217
               LET l_bgea.bgea023   = l_bgas.bgas218
               LET l_bgea.bgea024   = l_bgas.bgas219
               LET l_bgea.bgea025   = l_bgas.bgas310
               LET l_bgea.bgea026   = l_bgas.bgas311
               LET l_bgea.bgea027   = l_bgas.bgas312
               LET l_bgea.bgea028   = l_bgas.bgas313
               LET l_bgea.bgea029   = l_bgas.bgas314
               LET l_bgea.bgea030   = l_bgas.bgas315
               LET l_bgea.bgea031   = l_bgas.bgas410
               LET l_bgea.bgea032   = l_bgas.bgas411
               LET l_bgea.bgea033   = l_bgas.bgas412
               LET l_bgea.bgea034   = l_bgas.bgas414
               LET l_bgea.bgea035   = l_bgas.bgas415
               LET l_bgea.bgea036   = l_bgas.bgas416
               LET l_bgea.bgea037   = l_bgas.bgas417
               LET l_bgea.bgea038   = l_bgas.bgas418
               LET l_bgea.bgea039   = l_bgas.bgas419
               LET l_bgea.bgea040   = l_bgas.bgas420
               LET l_bgea.bgea041   = l_bgas.bgas421
               LET l_bgea.bgea042   = l_bgas.bgas422
               LET l_bgea.bgea043   = l_bgas.bgas423
               LET l_bgea.bgea044   = l_bgas.bgas413
            END IF                  
         ELSE
         #161129-00019#5 --e add
            #bgea_t寫入
            #INITIALIZE l_bgea.* TO NULL  #161129-00019#5 mark
            LET l_bgea.bgeaent   = g_enterprise
            LET l_bgea.bgea001   = g_bgea_m.bgea001
            LET l_bgea.bgea002   = l_bgea002
            LET l_bgea.bgea003   = l_bgas.bgas001
            LET l_bgea.bgea004   = ''
            LET l_bgea.bgea005   = ''
            LET l_bgea.bgea006   = ''
            LET l_bgea.bgea009   = l_bgas.bgas110
            LET l_bgea.bgea010   = l_bgas.bgas111
            LET l_bgea.bgea011   = l_bgas.bgas112
            LET l_bgea.bgea012   = l_bgas.bgas113
            LET l_bgea.bgea013   = l_bgas.bgas114
            LET l_bgea.bgea014   = l_bgas.bgas115
            LET l_bgea.bgea015   = l_bgas.bgas210
            LET l_bgea.bgea016   = l_bgas.bgas211
            LET l_bgea.bgea017   = l_bgas.bgas212
            LET l_bgea.bgea018   = l_bgas.bgas213
            LET l_bgea.bgea019   = l_bgas.bgas214
            LET l_bgea.bgea020   = l_bgas.bgas215
            LET l_bgea.bgea021   = l_bgas.bgas216
            LET l_bgea.bgea022   = l_bgas.bgas217
            LET l_bgea.bgea023   = l_bgas.bgas218
            LET l_bgea.bgea024   = l_bgas.bgas219
            LET l_bgea.bgea025   = l_bgas.bgas310
            LET l_bgea.bgea026   = l_bgas.bgas311
            LET l_bgea.bgea027   = l_bgas.bgas312
            LET l_bgea.bgea028   = l_bgas.bgas313
            LET l_bgea.bgea029   = l_bgas.bgas314
            LET l_bgea.bgea030   = l_bgas.bgas315
            LET l_bgea.bgea031   = l_bgas.bgas410
            LET l_bgea.bgea032   = l_bgas.bgas411
            LET l_bgea.bgea033   = l_bgas.bgas412
            LET l_bgea.bgea034   = l_bgas.bgas414
            LET l_bgea.bgea035   = l_bgas.bgas415
            LET l_bgea.bgea036   = l_bgas.bgas416
            LET l_bgea.bgea037   = l_bgas.bgas417
            LET l_bgea.bgea038   = l_bgas.bgas418
            LET l_bgea.bgea039   = l_bgas.bgas419
            LET l_bgea.bgea040   = l_bgas.bgas420
            LET l_bgea.bgea041   = l_bgas.bgas421
            LET l_bgea.bgea042   = l_bgas.bgas422
            LET l_bgea.bgea043   = l_bgas.bgas423
            LET l_bgea.bgea044   = l_bgas.bgas413
         END IF #161129-00019#5 add
         
         LET l_bgea.bgeastus  = 'Y'
         LET l_bgea.bgeaownid = g_user
         LET l_bgea.bgeaowndp = g_dept
         LET l_bgea.bgeacrtid = g_user
         LET l_bgea.bgeacrtdp = g_dept
         LET l_bgea.bgeacrtdt = ld_date
         LET l_bgea.bgeamodid = ''
         LET l_bgea.bgeamoddt = ''
         
         IF cl_null(l_bgea.bgea014) THEN LET l_bgea.bgea014 = "0" END IF
         IF cl_null(l_bgea.bgea020) THEN LET l_bgea.bgea020 = "0" END IF
         IF cl_null(l_bgea.bgea021) THEN LET l_bgea.bgea021 = "0" END IF
         IF cl_null(l_bgea.bgea022) THEN LET l_bgea.bgea022 = "0" END IF
         IF cl_null(l_bgea.bgea023) THEN LET l_bgea.bgea023 = "0" END IF
         IF cl_null(l_bgea.bgea024) THEN LET l_bgea.bgea024 = "0" END IF
         IF cl_null(l_bgea.bgea028) THEN LET l_bgea.bgea028 = "0" END IF
         IF cl_null(l_bgea.bgea029) THEN LET l_bgea.bgea029 = "0" END IF
         IF cl_null(l_bgea.bgea030) THEN LET l_bgea.bgea030 = "0" END IF
         IF cl_null(l_bgea.bgea032) THEN LET l_bgea.bgea032 = "0" END IF
         IF cl_null(l_bgea.bgea033) THEN LET l_bgea.bgea033 = "0" END IF
         IF cl_null(l_bgea.bgea034) THEN LET l_bgea.bgea034 = "0" END IF
         IF cl_null(l_bgea.bgea035) THEN LET l_bgea.bgea035 = "0" END IF
         IF cl_null(l_bgea.bgea036) THEN LET l_bgea.bgea036 = "0" END IF
         IF cl_null(l_bgea.bgea037) THEN LET l_bgea.bgea037 = "0" END IF
         IF cl_null(l_bgea.bgea038) THEN LET l_bgea.bgea038 = "0" END IF
         IF cl_null(l_bgea.bgea039) THEN LET l_bgea.bgea039 = "0" END IF
         IF cl_null(l_bgea.bgea040) THEN LET l_bgea.bgea040 = "0" END IF
         IF cl_null(l_bgea.bgea041) THEN LET l_bgea.bgea041 = "0" END IF
         IF cl_null(l_bgea.bgea042) THEN LET l_bgea.bgea042 = "0" END IF
         IF cl_null(l_bgea.bgea043) THEN LET l_bgea.bgea043 = "0" END IF
         
         #161129-00019#5 --s add ------------寫入前判斷--------------------
         #檢查是否已存在abgi170
         LET l_cnt = 0
         EXECUTE abgi165_02_cnt_p USING l_bgea.bgea002,l_bgea.bgea003  INTO l_cnt
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         
         #如有資料存在
         IF l_cnt > 0 THEN
            IF g_bgea_m.l_cover = 'N' THEN
            #資料已存在直接覆蓋= N : 只新增不存在 abgi170的資料  key:編號+組織+料號
               CONTINUE FOREACH
            END IF
         END IF
         
         #預算組織料件主檔_寫入前先刪除資料
         DELETE FROM bgea_t 
          WHERE bgeaent = g_enterprise 
            AND bgea001 = g_bgea_m.bgea001
            AND bgea002 = l_bgea.bgea002
            AND bgea003 = l_bgea.bgea003
         
         #預算組織料號對應檔_寫入前先刪除資料
         DELETE FROM bgeb_t 
          WHERE bgebent = g_enterprise 
            AND bgeb001 = g_bgea_m.bgea001
            AND bgeb002 = l_bgea.bgea002
            AND bgeb003 = l_bgea.bgea003            

         #預算組織料件內採對應檔_寫入前先刪除資料
         DELETE FROM bgec_t 
          WHERE bgecent = g_enterprise 
            AND bgec001 = g_bgea_m.bgea001  
            AND bgec002 = l_bgea.bgea002
            AND bgec003 = l_bgea.bgea003 
         #161129-00019#5 --e add ------------寫入前判斷--------------------             

         #寫入bgea_t 
         INSERT INTO bgea_t (bgeaent,bgea001,bgea002,bgea003,bgea004,
                             bgea005,bgea006,bgea009,bgea010,bgea011,
                             bgea012,bgea013,bgea014,bgea015,bgea016,
                             bgea017,bgea018,bgea019,bgea020,bgea021,
                             bgea022,bgea023,bgea024,bgea025,bgea026,
                             bgea027,bgea028,bgea029,bgea030,bgea031,
                             bgea032,bgea033,bgea034,bgea035,bgea036,
                             bgea037,bgea038,bgea039,bgea040,bgea041,
                             bgea042,bgea043,bgea044,bgeastus,bgeaownid,
                             bgeaowndp,bgeacrtid,bgeacrtdp,bgeacrtdt,bgeamodid,
                             bgeamoddt)
                     VALUES (l_bgea.*)                                                   
                            
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "ins_bgea_wrong"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
         
         #161129-00019#5 --s add
         #以來源abgi165對應料號中的料號,存在imaf否來決定寫入內容
         LET l_bgat002 = ''
         LET l_bgeb_do = 0
         FOREACH abgi165_02_bgat002_c USING l_bgas.bgas001,l_bgea002 INTO l_bgat002
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "FOREACH:abgi165_02_bgat002_c"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               EXIT FOREACH
            END IF 

            #預算組織料號對應檔
            LET l_bgeb.bgebent   = g_enterprise     #企業編號
            LET l_bgeb.bgeb001   = g_bgea_m.bgea001 #預算編號
            LET l_bgeb.bgeb002   = l_bgea.bgea002   #預算組織
            LET l_bgeb.bgeb003   = l_bgea.bgea003   #預算料號
            LET l_bgeb.bgeb004   = l_bgat002        #對應料號
            LET l_bgeb.bgebownid = g_user           #資料所有者
            LET l_bgeb.bgebowndp = g_dept           #資料所屬部門
            LET l_bgeb.bgebcrtid = g_user           #資料建立者
            LET l_bgeb.bgebcrtdp = g_dept           #資料建立部門
            LET l_bgeb.bgebcrtdt = ld_date          #資料創建日
            LET l_bgeb.bgebmodid = ''               #資料修改者
            LET l_bgeb.bgebmoddt = ''               #最近修改日
            LET l_bgeb.bgebstus  = 'Y'              #狀態碼

            #預算組織料批次產生時, 控管實體料只能對應一筆預算料
            LET l_success = TRUE
            LET l_errno = ''
            CALL s_abgi170_bgeb004_chk(l_bgeb.bgeb004,l_bgeb.bgeb003,l_bgeb.bgeb001,l_bgeb.bgeb002) RETURNING l_success,l_errno
            IF NOT l_success THEN
               CONTINUE FOREACH
            END IF

            #寫入bgea_t 
            INSERT INTO bgeb_t (bgebent,bgeb001,bgeb002,bgeb003,
                                bgeb004,bgebownid,bgebowndp,bgebcrtid,
                                bgebcrtdp,bgebcrtdt,bgebmodid,bgebmoddt,
                                bgebstus)
                        VALUES (l_bgeb.*)                                                   
                               
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = "ins_bgeb_wrong"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               EXIT FOREACH
            END IF  
            LET l_bgeb_do = l_bgeb_do+1
         END FOREACH
         
         #對應料件無資料,則寫入自己
         IF l_bgeb_do = 0 THEN
            LET l_bgeb.bgebent   = g_enterprise     #企業編號
            LET l_bgeb.bgeb001   = g_bgea_m.bgea001 #預算編號
            LET l_bgeb.bgeb002   = l_bgea.bgea002   #預算組織
            LET l_bgeb.bgeb003   = l_bgea.bgea003   #預算料號
            LET l_bgeb.bgeb004   = l_bgea.bgea003   #對應料號
            LET l_bgeb.bgebownid = g_user           #資料所有者
            LET l_bgeb.bgebowndp = g_dept           #資料所屬部門
            LET l_bgeb.bgebcrtid = g_user           #資料建立者
            LET l_bgeb.bgebcrtdp = g_dept           #資料建立部門
            LET l_bgeb.bgebcrtdt = ld_date          #資料創建日
            LET l_bgeb.bgebmodid = ''               #資料修改者
            LET l_bgeb.bgebmoddt = ''               #最近修改日
            LET l_bgeb.bgebstus  = 'Y'              #狀態碼
            
            #預算組織料批次產生時, 控管實體料只能對應一筆預算料
            LET l_success = TRUE
            LET l_errno = ''
            CALL s_abgi170_bgeb004_chk(l_bgeb.bgeb004,l_bgeb.bgeb003,l_bgeb.bgeb001,l_bgeb.bgeb002) RETURNING l_success,l_errno
            IF l_success THEN
               #寫入bgea_t 
               INSERT INTO bgeb_t (bgebent,bgeb001,bgeb002,bgeb003,
                                   bgeb004,bgebownid,bgebowndp,bgebcrtid,
                                   bgebcrtdp,bgebcrtdt,bgebmodid,bgebmoddt,
                                   bgebstus)
                           VALUES (l_bgeb.*)                                                   
                                  
               IF SQLCA.SQLcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = "ins_bgeb_own_wrong"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  EXIT FOREACH
               END IF 
            END IF              
         END IF
         #161129-00019#5 --e add
         LET l_cntdo = l_cntdo +1
      END FOREACH
      
      IF NOT r_success THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
   IF l_cntdo <= 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 

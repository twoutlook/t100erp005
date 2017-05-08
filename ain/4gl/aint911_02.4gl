#該程式未解開Section, 採用最新樣板產出!
{<section id="aint911_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-06-28 14:54:31), PR版次:0003(2016-11-18 09:50:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: aint911_02
#+ Description: 批量產生單身
#+ Creator....: 06137(2016-06-24 13:42:39)
#+ Modifier...: 06137 -SD/PR- 02749
 
{</section>}
 
{<section id="aint911_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160303-00028#20  2016/03/14  By sakura   修正自動帶出的單身，補貨規格說明沒有帶出
#160318-00005#37  2016/04/01  By 07900    修改重复错误讯息
#160318-00005#40  2016/04/22  By 07959    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#161117-00022#1   2016/11/18  By lori     筆數相關變數型態定義改為NUM10
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="aint911_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 TYPE type_g_imaa_d RECORD
       sel               LIKE type_t.chr500, 
       imaa001           LIKE imaa_t.imaa001, 
       imaa001_desc      LIKE type_t.chr500,
       imaa001_desc_1    LIKE type_t.chr500,   
       imaa014           LIKE imaa_t.imaa014,
       l_inbb202         LIKE inbb_t.inbb202,
       l_inbb201         LIKE inbb_t.inbb201,
       l_inbb201_desc    LIKE type_t.chr500, 
       l_inbb011         LIKE inbb_t.inbb011,
       l_inbb010         LIKE inbb_t.inbb010,
       l_inbb010_desc    LIKE type_t.chr500,  
       inag004           LIKE inag_t.inag004,
       inag004_desc      LIKE type_t.chr500,
       inag005           LIKE inag_t.inag005,
       inag005_desc      LIKE type_t.chr500,
       inag006           LIKE inag_t.inag006,
       inag009           LIKE inag_t.inag009
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_imaa_d          DYNAMIC ARRAY OF type_g_imaa_d #單身變數
DEFINE g_imaa_d_t        type_g_imaa_d                  #單身備份
DEFINE g_imaa_d_o        type_g_imaa_d                  #單身備份
DEFINE g_imaa_d_mask_o   DYNAMIC ARRAY OF type_g_imaa_d #單身變數
DEFINE g_imaa_d_mask_n   DYNAMIC ARRAY OF type_g_imaa_d #單身變數
 
 
DEFINE g_rec_b              LIKE type_t.num10           #161117-00022#1 161118 by lori mod:num5 to num10  
DEFINE g_wc                 STRING      
DEFINE g_wc2                STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_temp_idx           LIKE type_t.num10             #單身 所在筆數(暫存用)
DEFINE g_detail_idx         LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_chk                BOOLEAN
DEFINE g_aw                 STRING                        #確定當下點擊的單身
DEFINE g_log1               STRING                        #log用
DEFINE g_log2               STRING                        #log用
 
#多table用wc
DEFINE g_wc_table           STRING
#end add-point
 
{</section>}
 
{<section id="aint911_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_where_sql           STRING
DEFINE g_inag004_sql         STRING
DEFINE g_imaa009_sql         STRING
DEFINE g_type                LIKE type_t.num5
DEFINE g_inbadocno           LIKE inba_t.inbadocno   #領用單號
DEFINE g_inbasite            LIKE inba_t.inbasite    #營運組織
DEFINE g_inba                RECORD
       inbadocdt             LIKE inba_t.inbadocdt,  #領用日期
       inbasite              LIKE inba_t.inbasite,   #要貨組織
       inba015               LIKE inba_t.inba015,    #庫位
       inba203               LIKE inba_t.inba203,    #管理品類
       inba205               LIKE inba_t.inba205,    #領用部門
       inba007               LIKE inba_t.inba007,    #理由碼
       inba208               LIKE inba_t.inba208,    #返回
       inba006               LIKE inba_t.inba006,    #來源單號
       inba012               LIKE inba_t.inba012  
                             END RECORD
DEFINE l_imaa009             LIKE imaa_t.imaa009     #所屬品類
DEFINE imaa009_desc          LIKE type_t.chr100      #品類說明
DEFINE g_sys                 LIKE type_t.num5        #管理品類層級
DEFINE g_qty_sys             LIKE type_t.chr1        #雜項領用允許負庫存   #160604-00009#140 Add BY Ken 160711
#DEFINE g_success             LIKE type_t.num5
#end add-point
 
{</section>}
 
{<section id="aint911_02.other_dialog" >}

 
{</section>}
 
{<section id="aint911_02.other_function" readonly="Y" >}

PUBLIC FUNCTION aint911_02(--)
   #add-point:main段變數傳入
   p_type,
   p_inbadocno,
   p_inbasite
   #end add-point
   )
   #add-point:main段define
   DEFINE p_type          LIKE type_t.num5        #來源類別
   DEFINE p_inbadocno     LIKE inba_t.inbadocno   #領用單號
   DEFINE p_inbasite      LIKE inba_t.inbasite    #營運組織
   #end add-point
   #add-point:main段define(客製用)

   #end add-point

   IF cl_null(p_inbadocno) THEN
      RETURN
   END IF

   CREATE TEMP TABLE aint911_02_tmp (
       sel          LIKE type_t.chr1,       #選擇
       imaa001      LIKE imaa_t.imaa001,    #商品編號
       imaa014      LIKE imaa_t.imaa014,    #商品主條碼
       inbb202      LIKE inbb_t.inbb202,    #申請領用包裝數量
       inbb201      LIKE inbb_t.inbb201,    #申請領用包裝單位
       inbb011      LIKE inbb_t.inbb011,    #申請領用數量
       inbb010      LIKE inbb_t.inbb010,    #申請領用單位
       inag004      LIKE inag_t.inag004,    #庫位
       inag005      LIKE inag_t.inag005,    #儲位
       inag006      LIKE inag_t.inag006,    #批號
       inag009      LIKE inag_t.inag009);   #庫存數量
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #add-point:作業初始化

   #end add-point



   #LOCK CURSOR (identifier)


   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = "SELECT rtdx001,rtdx002,rtdx004,rtdx044 FROM rtdx_t WHERE rtdxent=? AND rtdxsite=?
       AND rtdx001=? FOR UPDATE"
   #add-point:main段define_sql

   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint911_02_bcl CURSOR FROM g_forupd_sql



   #畫面開啟 (identifier)
   OPEN WINDOW w_aint911_02 WITH FORM cl_ap_formpath("ain","aint911_02")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL aint911_02_init()
   
   LET g_type = p_type
   LET g_inbadocno = p_inbadocno
   LET g_inbasite = p_inbasite

   CALL aint911_02_get_inba()

   #LET g_success = TRUE
   #進入選單 Menu (="N")
   #CALL aint911_02_ui_dialog()
   CALL aint911_02_input()

   #畫面關閉
   CLOSE WINDOW w_aint911_02




   #add-point:離開前
   DROP TABLE aint911_02_tmp
   #end add-point
   #RETURN g_success
END FUNCTION

################################################################################

################################################################################
PRIVATE FUNCTION aint911_02_input()
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_where      STRING
DEFINE l_sql        STRING
DEFINE l_sys        LIKE type_t.num5   
DEFINE l_n          LIKE type_t.num5
DEFINE li_idx       LIKE type_t.num10

   CLEAR FORM
   CALL g_imaa_d.clear()

   INITIALIZE g_wc TO NULL

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
            
      #INPUT BY NAME l_imaa009 ATTRIBUTE(WITHOUT DEFAULTS) 
      #   
      #   
      #   BEFORE INPUT
      #      LET l_imaa009 = g_inba.inba203
      #      DISPLAY BY NAME l_imaa009
      #      
      #   AFTER FIELD l_imaa009
      #      LET imaa009_desc = ''
      #      DISPLAY BY NAME imaa009_desc    
      #      IF NOT cl_null(l_imaa009) THEN                            
      #           INITIALIZE g_chkparam.* TO NULL
      #            LET g_chkparam.arg1 = l_imaa009
      #            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      #            LET g_chkparam.arg2 = l_sys
      #            #160318-00025#40  2016/04/22  by pengxin  add(S)
      #            LET g_errshow = TRUE #是否開窗 
      #            LET g_chkparam.err_str[1] = "ast-00215:sub-01302|arti202|",cl_get_progname("arti202",g_lang,"2"),"|:EXEPROGarti202"
      #            #160318-00025#40  2016/04/22  by pengxin  add(E)
      #            #呼叫檢查存在並帶值的library
      #            IF NOT cl_chk_exist("v_rtax001_2") THEN
      #               LET l_imaa009 = ''
      #               #檢查失敗時後續處理
      #               NEXT FIELD CURRENT
      #            END IF
      #         
      #         #IF NOT cl_null(g_pmda.pmda003) THEN
      #         #   #檢查是否屬於arti204設置的部門品類
      #         #   LET l_n = 0
      #         #   SELECT COUNT(*) INTO l_n FROM rtaz_t
      #         #    WHERE rtazent = g_enterprise
      #         #      AND rtaz001 = g_prog
      #         #      AND rtazstus = 'Y'
      #         #   IF l_n > 0 THEN
      #         #      #當rtaz_t設定該程式代號 代表 該程式受arti204的控管
      #         #      SELECT COUNT(*) INTO l_n FROM rtay_t
      #         #       WHERE rtayent = g_enterprise
      #         #         AND rtay001 = g_pmda.pmda003
      #         #         AND rtay002 = l_imaa009
      #         #         AND rtaystus = 'Y'
      #         #      IF l_n < 1 THEN
      #         #         INITIALIZE g_errparam TO NULL
      #         #         LET g_errparam.code = 'apr-00357'
      #         #         LET g_errparam.extend = ''
      #         #         LET g_errparam.popup = TRUE
      #         #         CALL cl_err()                  
      #         #         LET l_imaa009 = ''
      #         #         NEXT FIELD CURRENT
      #         #      END IF
      #         #   END IF
      #         #END IF
      #      END IF         
      #      
      #      CALL s_desc_get_rtaxl003_desc(l_imaa009) RETURNING imaa009_desc
      #      DISPLAY BY NAME imaa009_desc          
      #
      #   #BEFORE FIELD l_imaa009
      #   #   IF NOT cl_null(l_imaa009) THEN
      #   #      NEXT FIELD NEXT
      #   #   END IF
      #
      #   #----<<l_imaa009>>----
      #   #Ctrlp:construct.c.limaa009
      #   ON ACTION controlp INFIELD l_imaa009
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'i'
      #      LET g_qryparam.reqry = FALSE
      #      LET g_qryparam.default1 = l_imaa009             #給予default值
		#	   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
      #      LET g_qryparam.arg1 = l_sys #
      #      CALL q_rtax001_3()                  #呼叫開窗
      #      LET l_imaa009 = g_qryparam.return1
      #      DISPLAY BY NAME l_imaa009
      #      CALL s_desc_get_rtaxl003_desc(l_imaa009) RETURNING imaa009_desc
      #      DISPLAY BY NAME imaa009_desc              
      #      NEXT FIELD l_imaa009                     #返回原欄位
      #              
      #END INPUT
      
      
      CONSTRUCT BY NAME g_wc ON inag004
         
         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         ON ACTION controlp INFIELD inag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_inbasite
            IF g_inba.inba208 != 'N' THEN
               LET g_qryparam.where = "inaa016 = 'N'"
            END IF
            IF NOT cl_null(g_inba.inba015) THEN
               IF cl_null(g_qryparam.where) THEN
                  LET g_qryparam.where = " inaa001 = '",g_inba.inba015,"'"  
               ELSE
                  LET g_qryparam.where = g_qryparam.where , " AND inag004 = '",g_inba.inba015,"'"
               END IF
            END IF
            CALL q_inaa001_6()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag004  #顯示到畫面上
            NEXT FIELD inag004                     #返回原欄位       
            
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc2 ON imaa009
         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         ON ACTION controlp INFIELD imaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.default1 = l_imaa009             #給予default值
			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
            LET g_qryparam.arg1 = l_sys #
            IF NOT cl_null(g_inba.inba203) THEN
               LET g_qryparam.where = " rtax001 = '",g_inba.inba203,"'"  
            END IF
            CALL q_rtax001_3()                  #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009
            #CALL s_desc_get_rtaxl003_desc(imaa009) RETURNING imaa009_desc
            #DISPLAY BY NAME imaa009_desc              
            NEXT FIELD imaa009                     #返回原欄位
            
      END CONSTRUCT      
      
      INPUT ARRAY g_imaa_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            CALL aint911_02_b_fill()
            #CALL aint911_02_set_entry_b("a")
            #CALL aint911_02_set_no_entry_b("a")               
            LET g_rec_b = g_imaa_d.getLength()
            DISPLAY "g_rec_b:",g_rec_b
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            LET g_imaa_d_t.* = g_imaa_d[l_ac].*
            LET g_imaa_d_o.* = g_imaa_d[l_ac].*            
            CALL aint911_02_set_entry_b("a")
            CALL aint911_02_set_no_entry_b("a")           

         #包裝數量
         AFTER FIELD l_inbb202
            IF NOT cl_ap_chk_range(g_imaa_d[l_ac].l_inbb202,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_inbb202
            END IF
            
            IF NOT cl_null(g_imaa_d[l_ac].l_inbb202) THEN
               IF g_imaa_d[l_ac].l_inbb202 != g_imaa_d_o.l_inbb202 OR cl_null(g_imaa_d_o.l_inbb202) THEN                         
                  CALL aint911_02_num_change()
               END IF
               #160604-00009#140 Add By Ken 160711(S)
               IF g_imaa_d[l_ac].l_inbb011 > 0 THEN               
                  IF NOT aint911_02_num_chk(g_imaa_d[l_ac].l_inbb011,g_imaa_d[l_ac].inag009) THEN
                     LET g_imaa_d[l_ac].l_inbb202 = g_imaa_d_o.l_inbb202
                     LET g_imaa_d[l_ac].l_inbb011 = g_imaa_d_o.l_inbb011                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #160604-00009#140 Add By Ken 160711(E)
            END IF
            CALL aint911_02_inbb011_upd()  
            LET g_imaa_d_o.l_inbb202 = g_imaa_d[l_ac].l_inbb202
            LET g_imaa_d_o.l_inbb011 = g_imaa_d[l_ac].l_inbb011
            CALL aint911_02_set_entry_b("a")
            CALL aint911_02_set_no_entry_b("a")
         
         #領用數量
         AFTER FIELD l_inbb011
            IF NOT cl_ap_chk_range(g_imaa_d[l_ac].l_inbb011,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_inbb011
            END IF                 
            
            IF NOT cl_null(g_imaa_d[l_ac].l_inbb011) THEN
               IF g_imaa_d[l_ac].l_inbb011 != g_imaa_d_o.l_inbb011 OR cl_null(g_imaa_d_o.l_inbb011) THEN          
                  CALL aint911_02_num_change()
               END IF
               #160604-00009#140 Add By Ken 160711(S)
               IF g_imaa_d[l_ac].l_inbb011 > 0 THEN
                  IF NOT aint911_02_num_chk(g_imaa_d[l_ac].l_inbb011,g_imaa_d[l_ac].inag009) THEN
                     LET g_imaa_d[l_ac].l_inbb202 = g_imaa_d_o.l_inbb202
                     LET g_imaa_d[l_ac].l_inbb011 = g_imaa_d_o.l_inbb011                    
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #160604-00009#140 Add By Ken 160711(E)               
            END IF
            CALL aint911_02_inbb011_upd()                
            LET g_imaa_d_o.l_inbb202 = g_imaa_d[l_ac].l_inbb202
            LET g_imaa_d_o.l_inbb011 = g_imaa_d[l_ac].l_inbb011
            CALL aint911_02_set_entry_b("a")
            CALL aint911_02_set_no_entry_b("a")

         ON CHANGE sel
            UPDATE aint911_02_tmp
               SET sel = g_imaa_d[l_ac].sel
             WHERE imaa001 = g_imaa_d[l_ac].imaa001
               AND inag004 = g_imaa_d[l_ac].inag004
               AND inag005 = g_imaa_d[l_ac].inag005
               AND inag006 = g_imaa_d[l_ac].inag006
            CALL aint911_02_set_entry_b("a")
            CALL aint911_02_set_no_entry_b("a")             
         ON ROW CHANGE
            CALL aint911_02_inbb011_upd()               
      END INPUT
      
      ##test---(S)
      #BEFORE DIALOG
      #  IF NOT cl_null(g_inba.inba015) THEN
      #     DISPLAY g_inba.inba015 TO inag004
      #     CALL cl_set_comp_entry('inag004',FALSE)
      #  ELSE
      #     CALL cl_set_comp_entry('inag004',TRUE)
      #  END IF
      #
      #  IF NOT cl_null(g_inba.inba203) THEN
      #     LET l_imaa009 = g_inba.inba203
      #     DISPLAY BY NAME l_imaa009
      #     CALL cl_set_comp_entry('l_imaa009',FALSE)
      #  ELSE
      #     CALL cl_set_comp_entry('l_imaa009',TRUE)
      #  END IF
      #
      #  IF NOT cl_null(g_inba.inba203) AND NOT cl_null(g_inba.inba015) THEN
      #     CALL aint911_02_gen_rtdx() 
      #  END IF
      ##test---(E)      
      
      ON ACTION data_ok
         #產生領用明細單身
         CALL aint911_02_gen_rtdx()      
                  
      ON ACTION check_all
         #採購明細單身全選
         CALL aint911_02_check_all() 
      
      ON ACTION check_no_all
         #採購明細單身全不選
         CALL aint911_02_check_no_all()
         
      ON ACTION gen_inbb
         ##產生要貨明細單身
      
         #檢查單身的必輸欄位不可為空
         #CALL aint911_02_b_fill()
         #LET g_rec_b = g_rtdx_d.getLength()
         
         IF g_rec_b > 0 THEN                             
            #IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb212,"0","0","","","azz-00079",1) THEN
            #   NEXT FIELD l_pmdb212
            #END IF  
            #IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].l_pmdb006,"0","0","","","azz-00079",1) THEN
            #   NEXT FIELD l_pmdb006
            #END IF    
            
            #150512-00026#1 Add By Ken 151214(S)
            IF l_ac > 0 THEN
               CALL aint911_02_num_change()
               CALL aint911_02_inbb011_upd()
            END IF 
            #150512-00026#1 Add By Ken 151214(E)            
            
             FOR li_idx = 1 TO g_imaa_d.getLength()
                IF g_imaa_d[li_idx].sel = "Y" THEN
                   IF cl_null(g_imaa_d[li_idx].l_inbb202) THEN  
                      NEXT FIELD l_inbb202
                   END IF
                   
                   IF cl_null(g_imaa_d[li_idx].l_inbb011) THEN
                      NEXT FIELD l_inbb011
                   END IF
                END IF
             END FOR            
            
             LET g_success = TRUE
             IF NOT aint911_02_gen_detail() THEN
                IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                   LET g_success = FALSE                 
                   RETURN
                END IF
             ELSE
                IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                   CALL g_imaa_d.clear()
                   DELETE FROM aint911_02_tmp
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'Del aint911_02_tmp'
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                   END IF
                   CALL aint911_02_gen_rtdx() 
                   CALL aint911_02_set_entry_b("a")
                   CALL aint911_02_set_no_entry_b("a")                                       
                   NEXT FIELD sel 
                ELSE
                   LET INT_FLAG = TRUE 
                   EXIT DIALOG
                END IF
             END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00292'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()      
         END IF
          
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
   
   IF INT_FLAG THEN
      RETURN
   END IF
END FUNCTION

PRIVATE FUNCTION aint911_02_b_fill()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5

    CALL g_imaa_d.clear()
    LET l_ac = 1
         
    LET l_sql = "SELECT sel,         imaa001,       t1.imaal003,      t1.imaal004, ", 
                "       imaa014,     inbb202,     inbb201,       t3.oocal003, ",
                "       inbb011,     inbb010,       t2.oocal003, ", 
                "       inag004,     t4.inayl003,   inag005,          '',  ",
                "       inag006,     inag009 ",
                "  FROM aint911_02_tmp ",
                "  LEFT OUTER JOIN imaal_t t1 ON t1.imaalent = ",g_enterprise,
                "                            AND t1.imaal001 = imaa001",
                "                            AND t1.imaal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN oocal_t t2 ON t2.oocalent = ",g_enterprise,
                "                            AND t2.oocal001 = inbb010",
                "                            AND t2.oocal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN oocal_t t3 ON t3.oocalent = ",g_enterprise,
                "                            AND t3.oocal001 = inbb201",
                "                            AND t3.oocal002 = '",g_dlang,"'",
                "  LEFT OUTER JOIN inayl_t t4 ON t4.inaylent = ",g_enterprise,
                "                            AND t4.inayl001 = inag004 ",
                "                            AND t4.inayl002 = '",g_dlang,"'",                              
                "  ORDER BY imaa001,inag004,inag005,inag006 "
    PREPARE aint911_02_imaa_pb FROM l_sql
    DECLARE aint911_02_imaa_cs CURSOR FOR aint911_02_imaa_pb
    FOREACH aint911_02_imaa_cs
       INTO g_imaa_d[l_ac].sel,                   g_imaa_d[l_ac].imaa001,             
            g_imaa_d[l_ac].imaa001_desc,          g_imaa_d[l_ac].imaa001_desc_1,      g_imaa_d[l_ac].imaa014,  
            g_imaa_d[l_ac].l_inbb202,             g_imaa_d[l_ac].l_inbb201,           g_imaa_d[l_ac].l_inbb201_desc, 
            g_imaa_d[l_ac].l_inbb011,             g_imaa_d[l_ac].l_inbb010,           g_imaa_d[l_ac].l_inbb010_desc,  
            g_imaa_d[l_ac].inag004,               g_imaa_d[l_ac].inag004_desc,        g_imaa_d[l_ac].inag005,        
            g_imaa_d[l_ac].inag005_desc,          g_imaa_d[l_ac].inag006,             g_imaa_d[l_ac].inag009           
                        
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "Foreach aint911_02_imaa_cs"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
       
             
       LET l_ac = l_ac + 1
       IF l_ac > g_max_rec AND g_error_show = 1 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code =  9035
          LET g_errparam.extend =  ''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    
    CALL g_imaa_d.deleteElement(g_imaa_d.getLength()) 
    LET l_ac = g_imaa_d.getLength()    
    
   
   #DEFINE p_wc2    STRING
   ##add-point:b_fill段define
   #
   ##end add-point
   ##add-point:b_fill段define(客製用)
   #
   ##end add-point
   #
   #IF cl_null(p_wc2) THEN
   #   LET p_wc2 = " 1=1"
   #END IF
   #
   ##add-point:b_fill段sql之前
   #
   ##end add-point
   #
   #LET g_sql = "SELECT  UNIQUE t0.rtdx001,t0.rtdx002,t0.rtdx004,t0.rtdx044 ,t1.imaal003 ,t3.oocal003 FROM rtdx_t t0",
   #
   #            "",
   #                           " LEFT JOIN imaal_t t1 ON t1.imaalent='"||g_enterprise||"' AND t1.imaal001=t0.rtdx001 AND t1.imaal002='"||g_dlang||"' ",
   #            " LEFT JOIN oocal_t t3 ON t3.oocalent='"||g_enterprise||"' AND t3.oocal001=t0.rtdx004 AND t3.oocal002='"||g_dlang||"' ",
   #
   #            " WHERE t0.rtdxent= ?  AND t0. rtdxsite= ?  AND  1=1 AND (", p_wc2, ") "
   ##add-point:b_fill段sql wc
   #
   ##end add-point
   #LET g_sql = g_sql, cl_sql_add_filter("rtdx_t"),
   #                   " ORDER BY t0.rtdx001"
   #
   ##add-point:b_fill段sql之後
   #
   ##end add-point
   #
   ##LET g_sql = cl_sql_add_tabid(g_sql,"rtdx_t")            #WC重組
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #PREPARE aint911_02_pb FROM g_sql
   #DECLARE b_fill_curs CURSOR FOR aint911_02_pb
   #
   #OPEN b_fill_curs USING g_enterprise, g_site
   #
   #CALL g_rtdx_d.clear()
   #
   #
   #LET g_cnt = l_ac
   #LET l_ac = 1
   #ERROR "Searching!"
   #
   #FOREACH b_fill_curs INTO g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044,
   #    g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx004_desc
   #   IF SQLCA.sqlcode THEN
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.extend = "FOREACH:"
   #      LET g_errparam.code   = SQLCA.sqlcode
   #      LET g_errparam.popup  = TRUE
   #      CALL cl_err()
   #      EXIT FOREACH
   #   END IF
   #
   #   #add-point:b_fill段資料填充
   #
   #   #end add-point
   #
   #   CALL aint911_02_detail_show()
   #
   #   IF l_ac > g_max_rec THEN
   #      IF g_error_show = 1 THEN
   #         INITIALIZE g_errparam TO NULL
   #         LET g_errparam.extend = l_ac
   #         LET g_errparam.code   = 9035
   #         LET g_errparam.popup  = TRUE
   #         CALL cl_err()
   #      END IF
   #      EXIT FOREACH
   #   END IF
   #
   #   LET l_ac = l_ac + 1
   #
   #END FOREACH
   #
   #LET g_error_show = 0
   #
   #
   #
   #CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength())
   #
   #
   ##將key欄位填到每個page
   #FOR l_ac = 1 TO g_rtdx_d.getLength()
   #
   #   #add-point:b_fill段key值相關欄位
   #
   #   #end add-point
   #END FOR
   #
   #IF g_cnt > g_rtdx_d.getLength() THEN
   #   LET l_ac = g_rtdx_d.getLength()
   #ELSE
   #   LET l_ac = g_cnt
   #END IF
   #LET g_cnt = l_ac
   #
   ##遮罩相關處理
   #FOR l_ac = 1 TO g_rtdx_d.getLength()
   #   LET g_rtdx_d_mask_o[l_ac].* =  g_rtdx_d[l_ac].*
   #   CALL aint911_02_rtdx_t_mask()
   #   LET g_rtdx_d_mask_n[l_ac].* =  g_rtdx_d[l_ac].*
   #END FOR
   #
   #
   #
   ##add-point:b_fill段資料填充(其他單身)
   #
   ##end add-point
   #
   #ERROR ""
   #
   #LET g_detail_cnt = g_rtdx_d.getLength()
   #DISPLAY g_detail_idx TO FORMONLY.idx
   #DISPLAY g_detail_cnt TO FORMONLY.cnt
   #
   #CLOSE b_fill_curs
   #FREE aint911_02_pb

END FUNCTION

PRIVATE FUNCTION aint911_02_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define

   #end add-point
   #add-point:default_search段define(客製用)

   #end add-point

   #add-point:default_search段開始前

   #end add-point

   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " rtdx001 = '", g_argv[01], "' AND "
   END IF



   #add-point:default_search段after sql

   #end add-point

   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_wc2 = ls_wc
   ELSE
      LET g_wc2 = " 1=1"
      #預設查詢條件
      LET g_wc2 = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc2) THEN
         LET g_wc2 = " 1=1"
      END IF
   END IF

   #add-point:default_search段結束前

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint911_02_delete()
   DEFINE li_idx          LIKE type_t.num10
   DEFINE li_ac_t         LIKE type_t.num10
   DEFINE li_detail_tmp   LIKE type_t.num10
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:delete段define

   #end add-point
   #add-point:delete段define(客製用)

   #end add-point

   #add-point:單身刪除前

   #end add-point

   CALL s_transaction_begin()

   LET li_ac_t = l_ac

   LET li_detail_tmp = g_detail_idx

   #lock所有所選資料
   FOR li_idx = 1 TO g_imaa_d.getLength()
      LET g_detail_idx = li_idx
      #已選擇的資料
      IF g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN
         #確定是否有被鎖定
         IF NOT aint911_02_lock_b("imaa_t") THEN
            #已被他人鎖定
            RETURN
         END IF
      END IF
   END FOR

   #add-point:單身刪除詢問前

   #end add-point

   #詢問是否確定刪除所選資料
   IF NOT cl_ask_del_detail() THEN
      RETURN
   END IF

   FOR li_idx = 1 TO g_imaa_d.getLength()
      IF g_imaa_d[li_idx].imaa001 IS NOT NULL

         AND g_curr_diag.isRowSelected(g_curr_diag.getCurrentItem(), li_idx) THEN

         #add-point:單身刪除前

         #end add-point

         DELETE FROM rtdx_t
          WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
                rtdx001 = g_imaa_d[li_idx].imaa001

         #add-point:單身刪除中

         #end add-point

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "rtdx_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            RETURN
         ELSE
            LET g_detail_cnt = g_detail_cnt-1
            LET l_ac = li_idx




            #add-point:單身同步刪除前(同層table)

            #end add-point
            LET g_detail_idx = li_idx
                           INITIALIZE gs_keys TO NULL
               LET gs_keys[1] = g_imaa_d_t.imaa001

            #add-point:單身同步刪除中(同層table)

            #end add-point
                           CALL aint911_02_delete_b('imaa_t',gs_keys,"'1'")
            #add-point:單身同步刪除後(同層table)

            #end add-point
         END IF
      END IF

   END FOR

   LET g_detail_idx = li_detail_tmp

   #add-point:單身刪除後

   #end add-point

   LET l_ac = li_ac_t

   #刷新資料
   CALL aint911_02_b_fill()

END FUNCTION

PRIVATE FUNCTION aint911_02_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define

   #end add-point
   #add-point:delete_b段define(客製用)

   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "rtdx_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 THEN
      IF ps_table <> 'rtdx_t' THEN
         #add-point:delete_b段刪除前

         #end add-point

         DELETE FROM rtdx_t
          WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
            rtdx001 = ps_keys_bak[1]

         #add-point:delete_b段刪除中

         #end add-point

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = FALSE
            CALL cl_err()
         END IF
      END IF

      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN
         CALL g_imaa_d.deleteElement(li_idx)
      END IF


      #add-point:delete_b段刪除後

      #end add-point

      RETURN
   END IF



END FUNCTION

PRIVATE FUNCTION aint911_02_detail_show()
   #add-point:show段define

   #end add-point
   #add-point:detail_show段define(客製用)

   #end add-point

   #add-point:detail_show段之前

   #end add-point



   #帶出公用欄位reference值page1




   #讀入ref值
   #add-point:show段單身reference

   #end add-point


   #add-point:detail_show段之後

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint911_02_init()
   #add-point:init段define

   #end add-point
   #add-point:init段define(客製用)

   #end add-point

   CALL g_imaa_d.clear()
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   LET g_error_show = 1

   #add-point:畫面資料初始化
   #隐藏
   CALL cl_set_comp_visible('sel',FALSE)
   CALL cl_set_comp_visible('check_all',FALSE)
   CALL cl_set_comp_visible('check_no_all',FALSE)
   #管理品類參數
   LET g_sys = cl_get_para(g_enterprise,"","E-CIR-0001")  


   #end add-point

   #CALL aint911_02_default_search()

END FUNCTION

PRIVATE FUNCTION aint911_02_insert()
   #add-point:delete段define

   #end add-point
   #add-point:insert段define(客製用)

   #end add-point

   #add-point:單身新增前

   #end add-point

   LET g_insert = 'Y'
   #CALL aint911_02_modify()

   #add-point:單身新增後

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint911_02_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:insert_b段define

   #end add-point
   #add-point:insert_b段define(客製用)

   #end add-point

   #判斷是否是同一群組的table
   LET ls_group = "rtdx_t,"
   #IF ls_group.getIndexOf(ps_table,1) > 0 THEN

      #add-point:insert_b段新增前

      #end add-point
      #INSERT INTO rtdx_t
      #            (rtdxent, rtdxsite,
      #             rtdx001
      #             ,rtdx002,rtdx004,rtdx044)
      #      VALUES(g_enterprise, g_site,
      #             ps_keys[1]
      #             ,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044)
      #add-point:insert_b段新增中

      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "rtdx_t"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = FALSE
         CALL cl_err()
      END IF
      #add-point:insert_b段新增後

      #end add-point
   #END IF



END FUNCTION

PRIVATE FUNCTION aint911_02_lock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:lock_b段define

   #end add-point
   #add-point:lock_b段define(客製用)

   #end add-point

   #先刷新資料
   #CALL aint911_02_b_fill()

   #鎖定整組table
   #LET ls_group = ""
   #僅鎖定自身table
   LET ls_group = "imaa_t"

   IF ls_group.getIndexOf(ps_table,1) THEN

      OPEN aint911_02_bcl USING g_enterprise, g_site,
                                       g_imaa_d[g_detail_idx].imaa001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "aint911_02_bcl"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF

   END IF



   RETURN TRUE

END FUNCTION

PRIVATE FUNCTION aint911_02_modify()
 #  DEFINE  l_cmd                  LIKE type_t.chr1
 #  DEFINE  l_ac_t                 LIKE type_t.num10               #未取消的ARRAY CNT
 #  DEFINE  l_n                    LIKE type_t.num10               #檢查重複用
 #  DEFINE  l_cnt                  LIKE type_t.num10               #檢查重複用
 #  DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否
 #  DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否
 #  DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否
 #  DEFINE  l_count                LIKE type_t.num10
 #  DEFINE  l_i                    LIKE type_t.num10
 #  DEFINE  ls_return              STRING
 #  DEFINE  l_var_keys             DYNAMIC ARRAY OF STRING
 #  DEFINE  l_field_keys           DYNAMIC ARRAY OF STRING
 #  DEFINE  l_vars                 DYNAMIC ARRAY OF STRING
 #  DEFINE  l_fields               DYNAMIC ARRAY OF STRING
 #  DEFINE  l_var_keys_bak         DYNAMIC ARRAY OF STRING
 #  DEFINE  li_reproduce           LIKE type_t.num10
 #  DEFINE  li_reproduce_target    LIKE type_t.num10
 #  DEFINE  lb_reproduce           BOOLEAN
 #  #add-point:modify段define
 #
 #  #end add-point
 #  #add-point:modify段define(客製用)
 #
 #  #end add-point
 #  LET g_action_choice = ""
 #
 #  LET g_qryparam.state = "i"
 #
 #  LET l_allow_insert = cl_auth_detail_input("insert")
 #  LET l_allow_delete = cl_auth_detail_input("delete")
 #
 #  #add-point:modify開始前
 #
 #  #end add-point
 #
 #  LET INT_FLAG = FALSE
 #  LET lb_reproduce = FALSE
 #
 #  #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
 #  #因此先行關閉, 若有需要可於下方add-point中自行開啟
 #  CALL cl_mask_set_no_entry()
 #
 #  #add-point:modify段修改前
 #
 #  #end add-point
 #
 #  DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 #
 #     #Page1 預設值產生於此處
 #     INPUT ARRAY g_rtdx_d FROM s_detail1.*
 #         ATTRIBUTE(COUNT = g_detail_cnt,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
 #                 INSERT ROW = l_allow_insert,
 #                 DELETE ROW = l_allow_delete,
 #                 APPEND ROW = l_allow_insert)
 #
 #        #自訂ACTION(detail_input,page_1)
 #
 #
 #        BEFORE INPUT
 #           IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
 #             CALL FGL_SET_ARR_CURR(g_rtdx_d.getLength()+1)
 #             LET g_insert = 'N'
 #          END IF
 #
 #           CALL aint911_02_b_fill()
 #           LET g_detail_cnt = g_rtdx_d.getLength()
 #
 #        BEFORE ROW
 #           #add-point:modify段before row
 #
 #           #end add-point
 #           LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
 #           LET l_cmd = ''
 #           LET l_ac = g_detail_idx
 #           LET l_lock_sw = 'N'            #DEFAULT
 #           LET l_n = ARR_COUNT()
 #           DISPLAY l_ac TO FORMONLY.idx
 #           DISPLAY g_rtdx_d.getLength() TO FORMONLY.cnt
 #
 #           CALL s_transaction_begin()
 #           LET g_detail_cnt = g_rtdx_d.getLength()
 #
 #           IF g_detail_cnt >= l_ac
 #              AND g_rtdx_d[l_ac].rtdx001 IS NOT NULL
 #
 #           THEN
 #              LET l_cmd='u'
 #              LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*  #BACKUP
 #              LET g_rtdx_d_o.* = g_rtdx_d[l_ac].*  #BACKUP
 #              IF NOT aint911_02_lock_b("rtdx_t") THEN
 #                 LET l_lock_sw='Y'
 #              ELSE
 #                 FETCH aint911_02_bcl INTO g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,
 #                     g_rtdx_d[l_ac].rtdx044
 #                 IF SQLCA.sqlcode THEN
 #                    INITIALIZE g_errparam TO NULL
 #                    LET g_errparam.extend = g_rtdx_d_t.rtdx001
 #                    LET g_errparam.code   = SQLCA.sqlcode
 #                    LET g_errparam.popup  = TRUE
 #                    CALL cl_err()
 #                    LET l_lock_sw = "Y"
 #                 END IF
 #
 #                 #遮罩相關處理
 #                 LET g_rtdx_d_mask_o[l_ac].* =  g_rtdx_d[l_ac].*
 #                 CALL aint911_02_rtdx_t_mask()
 #                 LET g_rtdx_d_mask_n[l_ac].* =  g_rtdx_d[l_ac].*
 #
 #                 CALL aint911_02_detail_show()
 #                 CALL cl_show_fld_cont()
 #              END IF
 #           ELSE
 #              LET l_cmd='a'
 #           END IF
 #           #add-point:modify段before row
 #
 #           #end add-point
 #           #其他table資料備份(確定是否更改用)
 #
 #           #其他table進行lock
 #
 #
 #        BEFORE INSERT
 #
 #           CALL s_transaction_begin()
 #           LET l_n = ARR_COUNT()
 #           LET l_cmd = 'a'
 #           INITIALIZE g_rtdx_d_t.* TO NULL
 #           INITIALIZE g_rtdx_d_o.* TO NULL
 #           INITIALIZE g_rtdx_d[l_ac].* TO NULL
 #           #公用欄位給值(單身)
 #
 #           #自定義預設值(單身1)
 #                 LET g_rtdx_d[l_ac].sel = "N"
 #     LET g_rtdx_d[l_ac].pmdb006 = "0"
 #     LET g_rtdx_d[l_ac].pmdb212 = "0"
 #     LET g_rtdx_d[l_ac].pmdb252 = "0"
 #
 #           #add-point:modify段before備份
 #
 #           #end add-point
 #           LET g_rtdx_d_t.* = g_rtdx_d[l_ac].*     #新輸入資料
 #           LET g_rtdx_d_o.* = g_rtdx_d[l_ac].*     #新輸入資料
 #           CALL cl_show_fld_cont()
 #           CALL aint911_02_set_entry_b("a")
 #           CALL aint911_02_set_no_entry_b("a")
 #           IF lb_reproduce THEN
 #              LET lb_reproduce = FALSE
 #              LET g_rtdx_d[li_reproduce_target].* = g_rtdx_d[li_reproduce].*
 #
 #              LET g_rtdx_d[g_rtdx_d.getLength()].rtdx001 = NULL
 #
 #           END IF
 #
 #           #add-point:modify段before insert
 #
 #           #end add-point
 #
 #        AFTER INSERT
 #           IF INT_FLAG THEN
 #              INITIALIZE g_errparam TO NULL
 #              LET g_errparam.extend = ''
 #              LET g_errparam.code   = 9001
 #              LET g_errparam.popup  = FALSE
 #              CALL cl_err()
 #              LET INT_FLAG = 0
 #              CANCEL INSERT
 #           END IF
 #
 #           LET l_count = 1
 #           SELECT COUNT(*) INTO l_count FROM rtdx_t
 #            WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND rtdx001 = g_rtdx_d[l_ac].rtdx001
 #
 #
 #           #資料未重複, 插入新增資料
 #           IF l_count = 0 THEN
 #              #add-point:單身新增前
 #
 #              #end add-point
 #
 #                             INITIALIZE gs_keys TO NULL
 #              LET gs_keys[1] = g_rtdx_d[g_detail_idx].rtdx001
 #              CALL aint911_02_insert_b('rtdx_t',gs_keys,"'1'")
 #
 #              #add-point:單身新增後
 #
 #              #end add-point
 #           ELSE
 #              INITIALIZE g_errparam TO NULL
 #              LET g_errparam.extend = 'INSERT'
 #              LET g_errparam.code   = "std-00006"
 #              LET g_errparam.popup  = TRUE
 #              CALL cl_err()
 #              INITIALIZE g_rtdx_d[l_ac].* TO NULL
 #              CANCEL INSERT
 #           END IF
 #
 #           IF SQLCA.SQLcode  THEN
 #              INITIALIZE g_errparam TO NULL
 #              LET g_errparam.extend = "rtdx_t"
 #              LET g_errparam.code   = SQLCA.sqlcode
 #              LET g_errparam.popup  = TRUE
 #              CALL cl_err()
 #              CANCEL INSERT
 #           ELSE
 #              #先刷新資料
 #              #CALL aint911_02_b_fill()
 #              #資料多語言用-增/改
 #
 #              #add-point:input段-after_insert
 #
 #              #end add-point
 #              ##ERROR 'INSERT O.K'
 #              LET g_detail_cnt = g_detail_cnt + 1
 #
 #              LET g_wc2 = g_wc2, " OR (rtdx001 = '", g_rtdx_d[l_ac].rtdx001, "' "
 #
 #                                 ,")"
 #           END IF
 #
 #        BEFORE DELETE                            #是否取消單身
 #           IF l_cmd = 'a' THEN
 #              LET l_cmd='d'
 #           ELSE
 #              #add-point:單身刪除ask前
 #
 #              #end add-point
 #
 #              IF NOT cl_ask_del_detail() THEN
 #                 CANCEL DELETE
 #              END IF
 #              IF l_lock_sw = "Y" THEN
 #                 INITIALIZE g_errparam TO NULL
 #                 LET g_errparam.extend = ""
 #                 LET g_errparam.code   = -263
 #                 LET g_errparam.popup  = TRUE
 #                 CALL cl_err()
 #                 CANCEL DELETE
 #              END IF
 #
 #              #add-point:單身刪除前
 #
 #              #end add-point
 #
 #              DELETE FROM rtdx_t
 #               WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
 #                     rtdx001 = g_rtdx_d_t.rtdx001
 #
 #
 #              #add-point:單身刪除中
 #
 #              #end add-point
 #
 #              IF SQLCA.sqlcode THEN
 #                 INITIALIZE g_errparam TO NULL
 #                 LET g_errparam.extend = "rtdx_t"
 #                 LET g_errparam.code   = SQLCA.sqlcode
 #                 LET g_errparam.popup  = TRUE
 #                 CALL cl_err()
 #                 CANCEL DELETE
 #              ELSE
 #                 LET g_detail_cnt = g_detail_cnt-1
 #
 #                 #add-point:單身刪除後
 #
 #                 #end add-point
 #                 #修改歷程記錄(刪除)
 #                 CALL aint911_02_set_pk_array()
 #                 IF NOT cl_log_modified_record('','') THEN
 #                 ELSE
 #                 END IF
 #              END IF
 #              CLOSE aint911_02_bcl
 #              #add-point:單身關閉bcl
 #
 #              #end add-point
 #              LET l_count = g_rtdx_d.getLength()
 #                             INITIALIZE gs_keys TO NULL
 #              LET gs_keys[1] = g_rtdx_d_t.rtdx001
 #
 #              #應用 a47 樣板自動產生(Version:2)
 #     #刪除相關文件
 #     CALL aint911_02_set_pk_array()
 #     #add-point:相關文件刪除前
 #
 #     #end add-point
 #     CALL cl_doc_remove()
 #
 #
 #
 #           END IF
 #
 #        AFTER DELETE
 #           IF l_cmd <> 'd' THEN
 #              #add-point:單身刪除後2
 #
 #              #end add-point
 #                             CALL aint911_02_delete_b('rtdx_t',gs_keys,"'1'")
 #           END IF
 #           #如果是最後一筆
 #           IF l_ac = (g_rtdx_d.getLength() + 1) THEN
 #              CALL FGL_SET_ARR_CURR(l_ac-1)
 #           END IF
 #
 #                 #應用 a01 樣板自動產生(Version:1)
 #        BEFORE FIELD sel
 #           #add-point:BEFORE FIELD sel
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD sel
 #
 #           #add-point:AFTER FIELD sel
 #
 #           #END add-point
 #
 #
 #        #應用 a04 樣板自動產生(Version:2)
 #        ON CHANGE sel
 #           #add-point:ON CHANGE sel
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD rtdx001
 #
 #           #add-point:AFTER FIELD rtdx001
 #           #應用 a05 樣板自動產生(Version:2)
 #           #確認資料無重複
 #           IF  g_rtdx_d[g_detail_idx].rtdx001 IS NOT NULL THEN
 #              IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_rtdx_d[g_detail_idx].rtdx001 != g_rtdx_d_t.rtdx001)) THEN
 #                 IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM rtdx_t WHERE "||"rtdxent = '" ||g_enterprise|| "' AND rtdxsite = '" ||g_site|| "' AND "||"rtdx001 = '"||g_rtdx_d[g_detail_idx].rtdx001 ||"'",'std-00004',0) THEN
 #                    NEXT FIELD CURRENT
 #                 END IF
 #              END IF
 #           END IF
 #
 #
 #           INITIALIZE g_ref_fields TO NULL
 #           LET g_ref_fields[1] = g_rtdx_d[l_ac].rtdx001
 #           CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
 #           LET g_rtdx_d[l_ac].rtdx001_desc = '', g_rtn_fields[1] , ''
 #           DISPLAY BY NAME g_rtdx_d[l_ac].rtdx001_desc
 #
 #
 #           #END add-point
 #
 #
 #        #應用 a01 樣板自動產生(Version:1)
 #        BEFORE FIELD rtdx001
 #           #add-point:BEFORE FIELD rtdx001
 #
 #           #END add-point
 #
 #        #應用 a04 樣板自動產生(Version:2)
 #        ON CHANGE rtdx001
 #           #add-point:ON CHANGE rtdx001
 #
 #           #END add-point
 #
 #        #應用 a01 樣板自動產生(Version:1)
 #        BEFORE FIELD rtdx002
 #           #add-point:BEFORE FIELD rtdx002
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD rtdx002
 #
 #           #add-point:AFTER FIELD rtdx002
 #
 #           #END add-point
 #
 #
 #        #應用 a04 樣板自動產生(Version:2)
 #        ON CHANGE rtdx002
 #           #add-point:ON CHANGE rtdx002
 #
 #           #END add-point
 #
 #        #應用 a02 樣板自動產生(Version:1)
 #        AFTER FIELD pmdb007
 #
 #           #add-point:AFTER FIELD pmdb007
 #           IF NOT cl_null(g_rtdx_d[l_ac].pmdb007) THEN
#應用 a17 樣板自動產生(Version:2)
  #             #欄位存在檢查
  #             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
  #             INITIALIZE g_chkparam.* TO NULL
  #
  #             #設定g_chkparam.*的參數
  #             LET g_chkparam.arg1 = g_rtdx_d[l_ac].pmdb007
  #
  #
  #             #呼叫檢查存在並帶值的library
  #             IF cl_chk_exist("v_ooca001") THEN
  #                #檢查成功時後續處理
  #             ELSE
  #                #檢查失敗時後續處理
  #                NEXT FIELD CURRENT
  #             END IF
  #
  #
  #          END IF
  #          INITIALIZE g_ref_fields TO NULL
  #          LET g_ref_fields[1] = g_rtdx_d[l_ac].pmdb007
  #          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
  #          LET g_rtdx_d[l_ac].pmdb007_desc = '', g_rtn_fields[1] , ''
  #          DISPLAY BY NAME g_rtdx_d[l_ac].pmdb007_desc
  #
  #
  #          #END add-point
  #
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb007
  #          #add-point:BEFORE FIELD pmdb007
  #
  #          #END add-point
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb007
  #          #add-point:ON CHANGE pmdb007
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb006
  #          #應用 a15 樣板自動產生(Version:2)
  #          #確認欄位值在特定區間內
  #          IF NOT cl_ap_chk_range(g_rtdx_d[l_ac].pmdb006,"0.000","0","","","azz-00079",1) THEN
  #             NEXT FIELD pmdb006
  #          END IF
  #
  #
  #          #add-point:AFTER FIELD pmdb006
  #          IF NOT cl_null(g_rtdx_d[l_ac].pmdb006) THEN
  #          END IF
  #
  #
  #          #END add-point
  #
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb006
  #          #add-point:BEFORE FIELD pmdb006
  #
  #          #END add-point
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb006
  #          #add-point:ON CHANGE pmdb006
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD rtdx004
  #
  #          #add-point:AFTER FIELD rtdx004
  #          INITIALIZE g_ref_fields TO NULL
  #          LET g_ref_fields[1] = g_rtdx_d[l_ac].rtdx004
  #          CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
  #          LET g_rtdx_d[l_ac].rtdx004_desc = '', g_rtn_fields[1] , ''
  #          DISPLAY BY NAME g_rtdx_d[l_ac].rtdx004_desc
  #
  #
  #          #END add-point
  #
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD rtdx004
  #          #add-point:BEFORE FIELD rtdx004
  #
  #          #END add-point
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE rtdx004
  #          #add-point:ON CHANGE rtdx004
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb212
  #          #add-point:BEFORE FIELD pmdb212
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb212
  #
  #          #add-point:AFTER FIELD pmdb212
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb212
  #          #add-point:ON CHANGE pmdb212
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD rtdx044
  #          #add-point:BEFORE FIELD rtdx044
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD rtdx044
  #
  #          #add-point:AFTER FIELD rtdx044
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE rtdx044
  #          #add-point:ON CHANGE rtdx044
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb252
  #          #add-point:BEFORE FIELD pmdb252
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb252
  #
  #          #add-point:AFTER FIELD pmdb252
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb252
  #          #add-point:ON CHANGE pmdb252
  #
  #          #END add-point
  #
  #       #應用 a01 樣板自動產生(Version:1)
  #       BEFORE FIELD pmdb259
  #          #add-point:BEFORE FIELD pmdb259
  #
  #          #END add-point
  #
  #       #應用 a02 樣板自動產生(Version:1)
  #       AFTER FIELD pmdb259
  #
  #          #add-point:AFTER FIELD pmdb259
  #
  #          #END add-point
  #
  #
  #       #應用 a04 樣板自動產生(Version:2)
  #       ON CHANGE pmdb259
  #          #add-point:ON CHANGE pmdb259
  #
  #          #END add-point
  #
  #
  #                #Ctrlp:input.c.page1.sel
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD sel
  #          #add-point:ON ACTION controlp INFIELD sel
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx001
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx001
  #          #add-point:ON ACTION controlp INFIELD rtdx001
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].rtdx001             #給予default值
  #          LET g_qryparam.default2 = "" #g_rtdx_d[l_ac].imaal003 #品名
  #          LET g_qryparam.default3 = "" #g_rtdx_d[l_ac].imaal004 #規格
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_imaa001()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].rtdx001 = g_qryparam.return1
  #          #LET g_rtdx_d[l_ac].imaal003 = g_qryparam.return2
  #          #LET g_rtdx_d[l_ac].imaal004 = g_qryparam.return3
  #          DISPLAY g_rtdx_d[l_ac].rtdx001 TO rtdx001              #
  #          #DISPLAY g_rtdx_d[l_ac].imaal003 TO imaal003 #品名
  #          #DISPLAY g_rtdx_d[l_ac].imaal004 TO imaal004 #規格
  #          NEXT FIELD rtdx001                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx002
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx002
  #          #add-point:ON ACTION controlp INFIELD rtdx002
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].rtdx002             #給予default值
  #
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_imay001()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].rtdx002 = g_qryparam.return1
  #
  #          DISPLAY g_rtdx_d[l_ac].rtdx002 TO rtdx002              #
  #
  #          NEXT FIELD rtdx002                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb007
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb007
  #          #add-point:ON ACTION controlp INFIELD pmdb007
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].pmdb007             #給予default值
  #
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_ooca001_1()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].pmdb007 = g_qryparam.return1
  #
  #          DISPLAY g_rtdx_d[l_ac].pmdb007 TO pmdb007              #
  #
  #          NEXT FIELD pmdb007                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb006
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb006
  #          #add-point:ON ACTION controlp INFIELD pmdb006
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx004
  #       #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx004
  #          #add-point:ON ACTION controlp INFIELD rtdx004
  #          #應用 a07 樣板自動產生(Version:2)
  #          #開窗i段
  #          INITIALIZE g_qryparam.* TO NULL
  #          LET g_qryparam.state = 'i'
  #          LET g_qryparam.reqry = FALSE
  #
  #          LET g_qryparam.default1 = g_rtdx_d[l_ac].rtdx004             #給予default值
  #
  #          #給予arg
  #          LET g_qryparam.arg1 = "" #
  #
  #
  #          CALL q_ooca001_1()                                #呼叫開窗
  #
  #          LET g_rtdx_d[l_ac].rtdx004 = g_qryparam.return1
  #
  #          DISPLAY g_rtdx_d[l_ac].rtdx004 TO rtdx004              #
  #
  #          NEXT FIELD rtdx004                          #返回原欄位
  #
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb212
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb212
  #          #add-point:ON ACTION controlp INFIELD pmdb212
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.rtdx044
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD rtdx044
  #          #add-point:ON ACTION controlp INFIELD rtdx044
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb252
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb252
  #          #add-point:ON ACTION controlp INFIELD pmdb252
  #
  #          #END add-point
  #
  #       #Ctrlp:input.c.page1.pmdb259
# #        #應用 a03 樣板自動產生(Version:2)
  #       ON ACTION controlp INFIELD pmdb259
  #          #add-point:ON ACTION controlp INFIELD pmdb259
  #
  #          #END add-point
  #
  #
  #
  #       ON ROW CHANGE
  #          IF INT_FLAG THEN
  #             INITIALIZE g_errparam TO NULL
  #             LET g_errparam.extend = ''
  #             LET g_errparam.code   = 9001
  #             LET g_errparam.popup  = FALSE
  #             CALL cl_err()
  #             LET INT_FLAG = 0
  #             LET g_rtdx_d[l_ac].* = g_rtdx_d_t.*
  #             CLOSE aint911_02_bcl
  #             #add-point:單身取消時
  #
  #             #end add-point
  #             EXIT DIALOG
  #          END IF
  #
  #          IF l_lock_sw = 'Y' THEN
  #             INITIALIZE g_errparam TO NULL
  #             LET g_errparam.extend = g_rtdx_d[l_ac].rtdx001
  #             LET g_errparam.code   = -263
  #             LET g_errparam.popup  = TRUE
  #             CALL cl_err()
  #             LET g_rtdx_d[l_ac].* = g_rtdx_d_t.*
  #          ELSE
  #             #寫入修改者/修改日期資訊(單身)
  #
  #
  #             #add-point:單身修改前
  #
  #             #end add-point
  #
  #             #將遮罩欄位還原
  #             CALL aint911_02_rtdx_t_mask_restore('restore_mask_o')
  #
  #             UPDATE rtdx_t SET (rtdx001,rtdx002,rtdx004,rtdx044) = (g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx002,
  #                 g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044)
  #              WHERE rtdxent = g_enterprise AND rtdxsite = g_site AND
  #                rtdx001 = g_rtdx_d_t.rtdx001 #項次
  #
  #
  #             #add-point:單身修改中
  #
  #             #end add-point
  #
  #             CASE
  #                WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
  #                   INITIALIZE g_errparam TO NULL
  #                   LET g_errparam.extend = "rtdx_t"
  #                   LET g_errparam.code   = "std-00009"
  #                   LET g_errparam.popup  = TRUE
  #                   CALL cl_err()
  #                  WHEN SQLCA.sqlcode #其他錯誤
  #                   INITIALIZE g_errparam TO NULL
  #                   LET g_errparam.extend = "rtdx_t"
  #                   LET g_errparam.code   = SQLCA.sqlcode
  #                   LET g_errparam.popup  = TRUE
  #                   CALL cl_err()
  #                OTHERWISE
  #                                  INITIALIZE gs_keys TO NULL
  #             LET gs_keys[1] = g_rtdx_d[g_detail_idx].rtdx001
  #             LET gs_keys_bak[1] = g_rtdx_d_t.rtdx001
  #             CALL aint911_02_update_b('rtdx_t',gs_keys,gs_keys_bak,"'1'")
  #                   #資料多語言用-增/改
  #
  #                   #修改歷程記錄(修改)
  #                   #LET g_log1 = util.JSON.stringify(g_rtdx_d_t)
  #                   #LET g_log2 = util.JSON.stringify(g_rtdx_d[l_ac])
  #                   IF NOT cl_log_modified_record(g_log1,g_log2) THEN
  #                   END IF
  #             END CASE
  #
  #             #將遮罩欄位進行遮蔽
  #             CALL aint911_02_rtdx_t_mask_restore('restore_mask_n')
  #
  #             #add-point:單身修改後
  #
  #             #end add-point
  #
  #          END IF
  #
  #       AFTER ROW
  #          CALL aint911_02_unlock_b("rtdx_t")
  #          #其他table進行unlock
  #
  #           #add-point:單身after row
  #
  #          #end add-point
  #
  #       AFTER INPUT
  #          #add-point:單身input後
  #
  #          #end add-point
  #          #錯誤訊息統整顯示
  #          #CALL cl_err_collect_show()
  #          #CALL cl_showmsg()
  #
  #       ON ACTION controlo
  #          CALL FGL_SET_ARR_CURR(g_rtdx_d.getLength()+1)
  #          LET lb_reproduce = TRUE
  #          LET li_reproduce = l_ac
  #          LET li_reproduce_target = g_rtdx_d.getLength()+1
  #
  #    END INPUT
  #
  #
  #
  #
  #
  #    #add-point:before_more_input
  #
  #    #end add-point
  #
  #    BEFORE DIALOG
  #       #CALL cl_err_collect_init()
  #       IF g_temp_idx > 0 THEN
  #          LET l_ac = g_temp_idx
  #          CALL DIALOG.setCurrentRow("s_detail1",l_ac)
  #          LET g_temp_idx = 1
  #       END IF
  #       #LET g_curr_diag = ui.DIALOG.getCurrent()
  #       #add-point:before_dialog
  #
  #       #end add-point
  #       CASE g_aw
  #          WHEN "s_detail1"
  #             NEXT FIELD sel
  #
  #       END CASE
  #
  #    ON ACTION accept
  #       ACCEPT DIALOG
  #
  #    ON ACTION cancel
  #       LET INT_FLAG = TRUE
  #       CANCEL DIALOG
  #
  #    ON ACTION controlr
  #       CALL cl_show_req_fields()
  #
  #    ON ACTION controlf
  #       CALL cl_set_focus_form(ui.Interface.getRootNode())
  #            RETURNING g_fld_name,g_frm_name
  #       CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
  #
  #    #交談指令共用ACTION
  #    &include "common_action.4gl"
  #       CONTINUE DIALOG
  #
  # END DIALOG
  #
  # #新增後取消
  # IF l_cmd = 'a' THEN
  #    #當取消或無輸入資料按確定時刪除對應資料
  #    IF INT_FLAG OR cl_null(g_rtdx_d[g_detail_idx].rtdx001) THEN
  #       CALL g_rtdx_d.deleteElement(g_detail_idx)
  #
  #    END IF
  # END IF
  #
  # #修改後取消
  # IF l_cmd = 'u' AND INT_FLAG THEN
  #    LET g_rtdx_d[g_detail_idx].* = g_rtdx_d_t.*
  # END IF
  #
  # #add-point:modify段修改後
  #
  # #end add-point
  #
  # CLOSE aint911_02_bcl

END FUNCTION

PRIVATE FUNCTION aint911_02_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define

   #end add-point
   #add-point:modify_detail_chk段define(客製用)

   #end add-point

   #add-point:modify_detail_chk段開始前

   #end add-point

   #根據sr名稱確定該page第一個欄位的名稱
   CASE ps_record
      WHEN "s_detail1"
         LET ls_return = "sel"

      #add-point:modify_detail_chk段自訂page控制

      #end add-point
   END CASE

   #add-point:modify_detail_chk段結束前

   #end add-point

   RETURN ls_return

END FUNCTION

PRIVATE FUNCTION aint911_02_query()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   #add-point:query段define

   #end add-point
   #add-point:query段define(客製用)

   #end add-point

   #LET INT_FLAG = 0
   #CLEAR FORM
   #CALL g_rtdx_d.clear()
   #
   #LET g_qryparam.state = "c"
   #
   ##wc備份
   #LET ls_wc = g_wc2
   #
   #DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #CONSTRUCT g_wc2 ON rtdx001,rtdx002,pmdb007,pmdb006,rtdx004,pmdb212,rtdx044,pmdb252,pmdb259
      #
      #   FROM s_detail1[1].rtdx001,s_detail1[1].rtdx002,s_detail1[1].pmdb007,s_detail1[1].pmdb006,s_detail1[1].rtdx004,
      #       s_detail1[1].pmdb212,s_detail1[1].rtdx044,s_detail1[1].pmdb252,s_detail1[1].pmdb259
      #
      #
      #
      #            #Ctrlp:construct.c.page1.rtdx001
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx001
      #      #add-point:ON ACTION controlp INFIELD rtdx001
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_imaa001()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO rtdx001  #顯示到畫面上
      #      NEXT FIELD rtdx001                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx001
      #      #add-point:BEFORE FIELD rtdx001
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx001
      #
      #      #add-point:AFTER FIELD rtdx001
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:construct.c.page1.rtdx002
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx002
      #      #add-point:ON ACTION controlp INFIELD rtdx002
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_imay001()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO rtdx002  #顯示到畫面上
      #      NEXT FIELD rtdx002                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx002
      #      #add-point:BEFORE FIELD rtdx002
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx002
      #
      #      #add-point:AFTER FIELD rtdx002
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:construct.c.page1.pmdb007
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb007
      #      #add-point:ON ACTION controlp INFIELD pmdb007
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_ooca001_1()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO pmdb007  #顯示到畫面上
      #      NEXT FIELD pmdb007                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb007
      #      #add-point:BEFORE FIELD pmdb007
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb007
      #
      #      #add-point:AFTER FIELD pmdb007
      #
      #      #END add-point
      #
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb006
      #      #add-point:BEFORE FIELD pmdb006
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb006
      #
      #      #add-point:AFTER FIELD pmdb006
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb006
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb006
      #      #add-point:ON ACTION controlp INFIELD pmdb006
      #
      #      #END add-point
      #
      #   #Ctrlp:construct.c.page1.rtdx004
      #   #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx004
      #      #add-point:ON ACTION controlp INFIELD rtdx004
      #      #應用 a08 樣板自動產生(Version:2)
      #      #開窗c段
      #      INITIALIZE g_qryparam.* TO NULL
      #      LET g_qryparam.state = 'c'
      #      LET g_qryparam.reqry = FALSE
      #      CALL q_ooca001_1()                           #呼叫開窗
      #      DISPLAY g_qryparam.return1 TO rtdx004  #顯示到畫面上
      #      NEXT FIELD rtdx004                     #返回原欄位
      #
      #
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx004
      #      #add-point:BEFORE FIELD rtdx004
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx004
      #
      #      #add-point:AFTER FIELD rtdx004
      #
      #      #END add-point
      #
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb212
      #      #add-point:BEFORE FIELD pmdb212
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb212
      #
      #      #add-point:AFTER FIELD pmdb212
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb212
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb212
      #      #add-point:ON ACTION controlp INFIELD pmdb212
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD rtdx044
      #      #add-point:BEFORE FIELD rtdx044
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD rtdx044
      #
      #      #add-point:AFTER FIELD rtdx044
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.rtdx044
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD rtdx044
      #      #add-point:ON ACTION controlp INFIELD rtdx044
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb252
      #      #add-point:BEFORE FIELD pmdb252
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb252
      #
      #      #add-point:AFTER FIELD pmdb252
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb252
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb252
      #      #add-point:ON ACTION controlp INFIELD pmdb252
      #
      #      #END add-point
      #
      #   #應用 a01 樣板自動產生(Version:1)
      #   BEFORE FIELD pmdb259
      #      #add-point:BEFORE FIELD pmdb259
      #
      #      #END add-point
      #
      #   #應用 a02 樣板自動產生(Version:1)
      #   AFTER FIELD pmdb259
      #
      #      #add-point:AFTER FIELD pmdb259
      #
      #      #END add-point
      #
      #
      #   #Ctrlp:query.c.page1.pmdb259
#     #    #應用 a03 樣板自動產生(Version:2)
      #   ON ACTION controlp INFIELD pmdb259
      #      #add-point:ON ACTION controlp INFIELD pmdb259
      #
      #      #END add-point
      #
      #
      #
      #
      #
      #   BEFORE CONSTRUCT
      #      #add-point:cs段more_construct
      #
      #      #end add-point
      #
      #END CONSTRUCT

      #add-point:query段more_construct

      #end add-point

      #BEFORE DIALOG
      #   CALL cl_qbe_init()
      #   #add-point:query段before_dialog
      #
      #   #end add-point
      #
      #ON ACTION qbe_select
      #   LET ls_wc = ""
      #   CALL cl_qbe_list("c") RETURNING ls_wc
      #
      #ON ACTION qbe_save
      #   CALL cl_qbe_save()
      #
      #ON ACTION accept
      #   ACCEPT DIALOG
      #
      #ON ACTION cancel
      #   LET INT_FLAG = 1
      #   CANCEL DIALOG
      #
      ##交談指令共用ACTION
      #&include "common_action.4gl"
      #CONTINUE DIALOG
   #END DIALOG

   #add-point:query段after_construct

   #end add-point

   #IF INT_FLAG THEN
   #   LET INT_FLAG = 0
   #   #還原
   #   LET g_wc2 = ls_wc
   #ELSE
   #   LET g_error_show = 1
   #   LET g_detail_idx = 1
   #END IF
   #
   #CALL aint911_02_b_fill()
   #
   #IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.extend = ""
   #   LET g_errparam.code   = -100
   #   LET g_errparam.popup  = TRUE
   #   CALL cl_err()
   #END IF
   #
   #LET INT_FLAG = FALSE

END FUNCTION

PRIVATE FUNCTION aint911_02_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_entry_b段define

   #end add-point
   #add-point:set_entry_b段define(客製用)

   #end add-point

   #add-point:set_entry_b段control
   CALL cl_set_comp_entry("l_inbb202,l_inbb011",TRUE)   
   #end add-point

END FUNCTION

PRIVATE FUNCTION aint911_02_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1
   #add-point:set_no_entry_b段define

   #end add-point
   #add-point:set_no_entry_b段define(客製用)

   #end add-point

   #add-point:set_no_entry_b段control
  #Mark By baogc 20151104 Begin ---
  #IF g_rtdx_d[l_ac].sel ='N' THEN
  #   CALL cl_set_comp_entry("l_pmdb006,l_pmdb212",FALSE) 
  #END IF
  #IF NOT cl_null(g_rtdx_d[l_ac].l_pmdb006) THEN
  #   CALL cl_set_comp_entry("l_pmdb212",FALSE) 
  #END IF
  #Mark By baogc 20151104 Begin ---
   #end add-point

END FUNCTION

PRIVATE FUNCTION aint911_02_set_pk_array()
   #add-point:set_pk_array段define

   #end add-point
   #add-point:set_pk_array段define

   #end add-point

   #add-point:set_pk_array段之前

   #end add-point

   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF

   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_imaa_d[l_ac].imaa001
   LET g_pk_array[1].column = 'imaa001'


   #add-point:set_pk_array段之後

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint911_02_ui_dialog()
   #DEFINE li_idx   LIKE type_t.num10
   #DEFINE la_param  RECORD #串查用
   #          prog   STRING,
   #          param  DYNAMIC ARRAY OF STRING
   #                 END RECORD
   #DEFINE ls_js     STRING
   ##add-point:ui_dialog段define
   #
   ##end add-point
   ##add-point:ui_dialog段define(客製用)
   #
   ##end add-point
   #
   #LET g_action_choice = " "
   #LET gwin_curr = ui.Window.getCurrent()
   #LET gfrm_curr = gwin_curr.getForm()
   #
   #CALL cl_set_act_visible("accept,cancel", FALSE)
   #
   #LET g_detail_idx = 1
   #
   ##add-point:ui_dialog段before dialog
   #
   ##end add-point
   #
   #WHILE TRUE
   #
   #   IF g_action_choice = "logistics" THEN
   #      #清除畫面及相關資料
   #      CLEAR FORM
   #      CALL g_rtdx_d.clear()
   #
   #      LET g_wc2 = ' 1=2'
   #      LET g_action_choice = ""
   #      CALL aint911_02_init()
   #   END IF
   #
   #   CALL aint911_02_b_fill()
   #
   #   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   #      DISPLAY ARRAY g_rtdx_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
   #
   #         BEFORE DISPLAY
   #            #add-point:ui_dialog段before display
   #
   #            #end add-point
   #            #讓各頁籤能夠同步指到特定資料
   #            CALL FGL_SET_ARR_CURR(g_detail_idx)
   #            #add-point:ui_dialog段before display2
   #
   #            #end add-point
   #
   #         BEFORE ROW
   #            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
   #            LET l_ac = g_detail_idx
   #            LET g_temp_idx = l_ac
   #            DISPLAY g_detail_idx TO FORMONLY.idx
   #            CALL cl_show_fld_cont()
   #            #顯示followup圖示
   #            #應用 a48 樣板自動產生(Version:2)
   #CALL aint911_02_set_pk_array()
   ##add-point:ON ACTION agendum
   #
   ##END add-point
   #CALL cl_user_overview_set_follow_pic()
   #
   #
   #
   #            #add-point:display array-before row
   #
   #            #end add-point
   #
   #         #自訂ACTION(detail_show,page_1)
   #
   #
   #      END DISPLAY
   #
   #
   #
   #      #add-point:ui_dialog段自定義display array
   #
   #      #end add-point
   #
   #      BEFORE DIALOG
   #         IF g_temp_idx > 0 THEN
   #            LET l_ac = g_temp_idx
   #            CALL DIALOG.setCurrentRow("s_detail1",l_ac)
   #            LET g_temp_idx = 1
   #         END IF
   #         LET g_curr_diag = ui.DIALOG.getCurrent()
   #         CALL DIALOG.setSelectionMode("s_detail1", 1)
   #
   #         #add-point:ui_dialog段before
   #
   #         #end add-point
   #         NEXT FIELD CURRENT
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION modify
   #         LET g_action_choice="modify"
   #         IF cl_auth_chk_act("modify") THEN
   #            LET g_aw = ''
   #            CALL aint911_02_modify()
   #            #add-point:ON ACTION modify
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION modify_detail
   #         LET g_action_choice="modify_detail"
   #         IF cl_auth_chk_act("modify") THEN
   #            LET g_aw = g_curr_diag.getCurrentItem()
   #            CALL aint911_02_modify()
   #            #add-point:ON ACTION modify_detail
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION delete
   #         LET g_action_choice="delete"
   #         IF cl_auth_chk_act("delete") THEN
   #            CALL aint911_02_delete()
   #            #add-point:ON ACTION delete
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION insert
   #         LET g_action_choice="insert"
   #         IF cl_auth_chk_act("insert") THEN
   #            CALL aint911_02_insert()
   #            #add-point:ON ACTION insert
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION output
   #         LET g_action_choice="output"
   #         IF cl_auth_chk_act("output") THEN
   #
   #            #add-point:ON ACTION output
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION reproduce
   #         LET g_action_choice="reproduce"
   #         IF cl_auth_chk_act("reproduce") THEN
   #
   #            #add-point:ON ACTION reproduce
   #
   #            #END add-point
   #
   #         END IF
   #
   #
   #
   #      #應用 a43 樣板自動產生(Version:2)
   #      ON ACTION query
   #         LET g_action_choice="query"
   #         IF cl_auth_chk_act("query") THEN
   #            CALL aint911_02_query()
   #            #add-point:ON ACTION query
   #
   #            #END add-point
   #            #應用 a59 樣板自動產生(Version:2)
   #            CALL g_curr_diag.setCurrentRow("s_detail1",1)
   #
   #
   #
   #         END IF
   #
   #
   #
   #
   #      ON ACTION exporttoexcel
   #         LET g_action_choice="exporttoexcel"
   #         IF cl_auth_chk_act("exporttoexcel") THEN
   #            CALL g_export_node.clear()
   #            LET g_export_node[1] = base.typeInfo.create(g_rtdx_d)
   #            LET g_export_id[1]   = "s_detail1"
   #
   #            #add-point:ON ACTION exporttoexcel
   #
   #            #END add-point
   #            CALL cl_export_to_excel_getpage()
   #            CALL cl_export_to_excel()
   #         END IF
   #
   #      ON ACTION close
   #         LET INT_FLAG=FALSE
   #         LET g_action_choice="exit"
   #         CANCEL DIALOG
   #
   #      ON ACTION exit
   #         LET g_action_choice="exit"
   #         CANCEL DIALOG
   #
   #
   #
   #      #應用 a46 樣板自動產生(Version:2)
   #      #新增相關文件
   #      ON ACTION related_document
   #         CALL aint911_02_set_pk_array()
   #         IF cl_auth_chk_act("related_document") THEN
   #            #add-point:ON ACTION related_document
   #
   #            #END add-point
   #            CALL cl_doc()
   #         END IF
   #
   #      ON ACTION agendum
   #         CALL aint911_02_set_pk_array()
   #         #add-point:ON ACTION agendum
   #
   #         #END add-point
   #         CALL cl_user_overview()
   #         CALL cl_user_overview_set_follow_pic()
   #
   #      ON ACTION followup
   #         CALL aint911_02_set_pk_array()
   #         #add-point:ON ACTION followup
   #
   #         #END add-point
   #         CALL cl_user_overview_follow('')
   #
   #
   #
   #      #主選單用ACTION
   #      &include "main_menu_exit_dialog.4gl"
   #      &include "relating_action.4gl"
   #      #交談指令共用ACTION
   #      &include "common_action.4gl"
   #         CONTINUE DIALOG
   #   END DIALOG
   #
   #   IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
   #      #add-point:ui_dialog段離開dialog前
   #
   #      #end add-point
   #      EXIT WHILE
   #   END IF
   #
   #END WHILE
   #
   #CALL cl_set_act_visible("accept,cancel", TRUE)
   #
END FUNCTION

PRIVATE FUNCTION aint911_02_unlock_b(ps_table)
   DEFINE ps_table STRING
   DEFINE ls_group STRING
   #add-point:unlock_b段define

   #end add-point
   #add-point:unlock_b段define(客製用)

   #end add-point

   LET ls_group = ""

   #IF ls_group.getIndexOf(ps_table,1) THEN
      CLOSE aint911_02_bcl
   #END IF



   #add-point:unlock_b段結束前

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint911_02_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_page          STRING
   DEFINE ps_table         STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define

   #end add-point
   #add-point:update_b段define(客製用)

   #end add-point

   #比對新舊值, 判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR

   #若key無變動, 不需要做處理
   IF lb_chk THEN
      RETURN
   END IF

   #若key有變動, 則連動其他table的資料
   #判斷是否是同一群組的table
   LET ls_group = "rtdx_t,"
   IF ls_group.getIndexOf(ps_table,1) > 0 AND ps_table <> "rtdx_t" THEN
      #add-point:update_b段修改前

      #end add-point
      #UPDATE rtdx_t
      #   SET (rtdx001
      #        ,rtdx002,rtdx004,rtdx044)
      #        =
      #       (ps_keys[1]
      #        ,g_rtdx_d[l_ac].rtdx002,g_rtdx_d[l_ac].rtdx004,g_rtdx_d[l_ac].rtdx044)
      #   WHERE rtdx001 = ps_keys_bak[1]
      #add-point:update_b段修改中

      #end add-point
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "rtdx_t"
            LET g_errparam.code   = "std-00009"
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "rtdx_t"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
         OTHERWISE

      END CASE
      #add-point:update_b段修改後

      #end add-point
      RETURN
   END IF



END FUNCTION

################################################################################
# Descriptions...: 產生要貨單明細相關語法
# Memo...........:
# Usage..........: CALL aint911_02_gen_detail_pre()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_gen_detail_pre()
DEFINE l_sql     STRING

   LET l_sql = "SELECT imaa001     ,       imaa014      ,       inbb202      ,       inbb201, ",
               "       inbb011     ,       inbb010      ,       inag004      ,       inag005      ,       inag006, ",
               "       inag009      ",
               "  FROM aint911_02_tmp  ",
               " WHERE sel = 'Y' "
   PREPARE aint911_02_sel_pre FROM l_sql
   DECLARE aint911_02_sel_cs CURSOR FOR aint911_02_sel_pre
   
   #項次
   LET l_sql = "SELECT COALESCE(MAX(inbbseq),0)+1",
               "  FROM inbb_t",
               " WHERE inbbent = ",g_enterprise,
               "   AND inbbdocno = '",g_inbadocno,"'"
   PREPARE aint911_02_inbbseq FROM l_sql
   
   ##供應商
   #LET l_sql = "SELECT imaf153",
   #            "  FROM imaf_t",
   #            " WHERE imafent = ",g_enterprise,
   #            "   AND imafsite = ?",
   #            "   AND imaf001 = ?"
   #PREPARE aint911_02_imaf153 FROM l_sql
   
   ##結算方式、採購員
   #LET l_sql = "SELECT DISTINCT star006,stas009",
   #            "  FROM stan_t,star_t,stas_t",
   #            " WHERE starent = stasent",
   #            "   AND starsite = stassite ",
   #            "   AND star001 = stas001",
   #            "   AND stanent = starent",
   #            "   AND stan001 = star004",
   #            "   AND stanent = ",g_enterprise,
   #            "   AND starsite = ? ", #add by geza 20150603
   #            "   AND stas003 = ?",
   #            "   AND star003 = ?",
   #            "   AND starstus = 'Y'",
   #            #"   AND '",g_pmda.pmdadocdt,"' BETWEEN stan017 AND stan018"   #160104-00014#1 20160104 mark by beckxie
   #            "   AND '",g_pmda.pmdadocdt,"' BETWEEN stas018 AND stas019"    #160104-00014#1 20160104  add by beckxie
   #PREPARE aint911_02_get_star FROM l_sql
   
   ##採購方式
   #LET l_sql = "SELECT rtdx027,rtdx003",
   #            "  FROM rtdx_t",
   #            " WHERE rtdxent = ",g_enterprise,
   #            "   AND rtdxsite = ?",
   #            "   AND rtdx001 = ?"
   #PREPARE aint911_02_get_rtdx FROM l_sql
END FUNCTION

################################################################################
# Descriptions...: 產生要貨單明細資料
# Memo...........:
# Usage..........: CALL aint911_02_gen_detail()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_gen_detail()
DEFINE l_i              LIKE type_t.num5
DEFINE l_imaa            RECORD
       imaa001           LIKE imaa_t.imaa001,    #商品編號
       imaa014           LIKE imaa_t.imaa014,    #商品主條碼
       inbb202           LIKE inbb_t.inbb202,    #申請領用包裝數量
       inbb201           LIKE inbb_t.inbb201,    #申請領用包裝單位
       inbb011           LIKE inbb_t.inbb011,    #申請領用數量
       inbb010           LIKE inbb_t.inbb010,    #申請領用單位
       inag004           LIKE inag_t.inag004,    #庫位
       inag005           LIKE inag_t.inag005,    #儲位
       inag006           LIKE inag_t.inag006,    #批號
       inag009           LIKE inag_t.inag009                         
                         END RECORD  
DEFINE l_inbb   RECORD   
       inbbent        LIKE   inbb_t.inbbent,        #企業編號
       inbbunit       LIKE   inbb_t.inbbunit,       #應用組織
       inbbsite       LIKE   inbb_t.inbbsite,       #營運據點
       inbbseq        LIKE   inbb_t.inbbseq,        #項次
       inbbdocno      LIKE   inbb_t.inbbdocno,      #單據編號
       inbb021        LIKE   inbb_t.inbb021,        #存貨備註
       inbb001        LIKE   inbb_t.inbb001,        #料件編號
       inbb002        LIKE   inbb_t.inbb002,        #產品特徵
       inbb003        LIKE   inbb_t.inbb003,        #庫存管理特徵
       inbb004        LIKE   inbb_t.inbb004,        #包裝容器編號
       inbb007        LIKE   inbb_t.inbb007,        #庫位
       inbb008        LIKE   inbb_t.inbb008,        #限定儲位
       inbb009        LIKE   inbb_t.inbb009,        #限定批號
       inbb010        LIKE   inbb_t.inbb010,        #交易單位
       inbb011        LIKE   inbb_t.inbb011,        #申請數量
       inbb012        LIKE   inbb_t.inbb012,        #實際異動數量
       inbb013        LIKE   inbb_t.inbb013,        #參考單位
       inbb014        LIKE   inbb_t.inbb014,        #參考單位申請數量
       inbb015        LIKE   inbb_t.inbb015,        #參考單位實際數量
       inbb016        LIKE   inbb_t.inbb016,        #理由碼
       inbb017        LIKE   inbb_t.inbb017,        #來源單號
       inbb018        LIKE   inbb_t.inbb018,        #檢驗否
       inbb019        LIKE   inbb_t.inbb019,        #檢驗合格量
       inbb020        LIKE   inbb_t.inbb020,        #單據備註
       inbb022        LIKE   inbb_t.inbb022,        #有效日期
       inbb023        LIKE   inbb_t.inbb023,        #專案編號
       inbb024        LIKE   inbb_t.inbb024,        #WBS
       inbb025        LIKE   inbb_t.inbb025,        #活動編號
       inbb200        LIKE   inbb_t.inbb200,        #商品條碼
       inbb201        LIKE   inbb_t.inbb201,        #包裝單位
       inbb202        LIKE   inbb_t.inbb202,        #申請包裝數量
       inbb203        LIKE   inbb_t.inbb203,        #實際包裝數量
       inbb204        LIKE   inbb_t.inbb204,        #製造日期
       inbb205        LIKE   inbb_t.inbb205,        #領用/退回單價
       inbb206        LIKE   inbb_t.inbb206,        #領用/退回金額
       inbb207        LIKE   inbb_t.inbb207,        #成本單價
       inbb208        LIKE   inbb_t.inbb208,        #成本金額
       inbb209        LIKE   inbb_t.inbb209,        #費用編號
       inbb210        LIKE   inbb_t.inbb210,        #進價
       inbb211        LIKE   inbb_t.inbb211,        #來源單據項次
       inbb212        LIKE   inbb_t.inbb212,        #來源單據項序
       #inbb213        LIKE   inbb_t.inbb213,        #轉入商品條碼
       #inbb214        LIKE   inbb_t.inbb214,        #轉入商品編號
       #inbb215        LIKE   inbb_t.inbb215,        #轉入產品特徵
       #inbb216        LIKE   inbb_t.inbb216,        #轉入單位
       #inbb217        LIKE   inbb_t.inbb217,        #轉入數量
       #inbb218        LIKE   inbb_t.inbb218,        #轉入包裝單位
       #inbb219        LIKE   inbb_t.inbb219,        #轉入包裝數量
       #inbb220        LIKE   inbb_t.inbb220,        #轉入庫位
       #inbb221        LIKE   inbb_t.inbb221,        #轉入儲位
       #inbb222        LIKE   inbb_t.inbb222,        #轉入批號
       #inbb223        LIKE   inbb_t.inbb223,        #轉入進價
       inbb224        LIKE   inbb_t.inbb224,        #計價單位
       inbb225        LIKE   inbb_t.inbb225         #計價數量
                         END RECORD
DEFINE l_imaa005        LIKE imaa_t.imaa005   #特徵組
DEFINE l_imaa006        LIKE imaa_t.imaa006   #基礎單位  
DEFINE l_imaf055        LIKE imaf_t.imaf055   #庫存管理特徵
DEFINE l_imaf061        LIKE imaf_t.imaf061   #庫存批號控管方式
DEFINE l_imaf091        LIKE imaf_t.imaf091   #預設庫位
DEFINE l_imaf092        LIKE imaf_t.imaf092   #預設儲位                         
DEFINE l_inbb022        LIKE inbb_t.inbb022
DEFINE l_success        LIKE type_t.num5
DEFINE l_sys2           LIKE type_t.num5
DEFINE l_slip_no        LIKE inba_t.inbadocno
DEFINE l_cost           LIKE type_t.num20_6
DEFINE l_rtdx034        LIKE rtdx_t.rtdx034
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   CALL aint911_02_gen_detail_pre()
   
   FOREACH aint911_02_sel_cs
      INTO l_imaa.imaa001,  l_imaa.imaa014, l_imaa.inbb202, l_imaa.inbb201, l_imaa.inbb011, 
           l_imaa.inbb010,  l_imaa.inag004, l_imaa.inag005, l_imaa.inag006, l_imaa.inag009
           
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach aint911_02_sel_cs"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      LET l_inbb.inbbent   = g_enterprise        #企業編號           
      LET l_inbb.inbbsite  = g_inba.inbasite     #營運據點    
      LET l_inbb.inbbdocno = g_inbadocno         #領用單號

      
      EXECUTE aint911_02_inbbseq INTO l_inbb.inbbseq  #項次
      
      LET l_inbb.inbb001   = l_imaa.imaa001      #商品編號
      
      LET l_imaa005 = ''
      LET l_imaa006 = ''
      LET l_imaf055 = ''
      LET l_imaf061 = ''
      LET l_imaf091 = ''
      LET l_imaf092 = ''     
      CALL s_aint911_get_prod_info(l_inbb.inbb001)
         RETURNING l_imaa005,l_imaa006,l_imaf055,l_imaf061,l_imaf091,l_imaf092       
     
      IF NOT cl_null(l_imaa.inag004) THEN         
         LET l_inbb.inbb007 = l_imaa.inag004     #庫位        
         LET l_inbb.inbb008 = ''                 #儲位
      ELSE                 
         LET l_inbb.inbb007 = l_imaf091          #庫位         
         LET l_inbb.inbb008 = l_imaf092          #儲位
      END IF     
      
      LET l_inbb.inbb002   = ' '                 #產品特徵
      LET l_inbb.inbb003   = ' '                 #庫存管理特徵      
      LET l_inbb.inbb004   = ''                  #包裝容器編號 
      #LET l_inbb.inbb007   = l_imaa.inag004      #庫位
      IF cl_null(l_inbb.inbb008) THEN
         LET l_inbb.inbb008   = ' '      #儲位
      END IF
      IF cl_null(l_inbb.inbb009) THEN
         LET l_inbb.inbb009   = ' '      #批號
      END IF
      LET l_inbb.inbb010   = l_imaa.inbb010      #交易單位
      LET l_inbb.inbb011   = l_imaa.inbb011      #申請數量
      LET l_inbb.inbb012   = l_inbb.inbb011      #實際異動數量
      LET l_inbb.inbb013   = ''                  #參考單位
      LET l_inbb.inbb014   = 0                   #參考單位申請數量
      LET l_inbb.inbb015   = 0                   #參考單位實際數量
      LET l_inbb.inbb016   = g_inba.inba007      #理由碼
      LET l_inbb.inbb017   = ''                  #來源單號
      LET l_inbb.inbb018   = ''                  #檢驗否
      LET l_inbb.inbb019   = 0                   #檢驗否格量
      LET l_inbb.inbb020   = ''                  #單據備註
      LET l_inbb.inbb021   = ''                  #存貨備註
      LET l_inbb.inbb022   = ''                  #有效日期
      LET l_inbb.inbb200   = l_imaa.imaa014      #商品條碼
      LET l_inbb.inbb201   = l_imaa.inbb201      #包裝單位
      LET l_inbb.inbb202   = l_imaa.inbb202      #申請包裝數量
      LET l_inbb.inbb203   = 0                   #實際包裝數量
      LET l_inbb.inbbunit  = ''                  #應用組織
      LET l_inbb.inbb204   = g_inba.inbadocdt    #製造日期
      LET l_inbb.inbb023   = ''                  #專案編號
      LET l_inbb.inbb024   = ''                  #WBS
      LET l_inbb.inbb025   = ''                  #活動編號
      LET l_inbb.inbb205   = 0                   #領用/退回單價
      LET l_inbb.inbb206   = 0                   #領用/退回金額
      LET l_inbb.inbb207   = 0                   #成本單價
      LET l_inbb.inbb208   = 0                   #成本金額
      LET l_inbb.inbb209   = ''                  #費用編號
      LET l_inbb.inbb210   = 0                   #進價
      LET l_inbb.inbb211   = NULL                #來源單據項次
      LET l_inbb.inbb212   = NULL                #來源單據項序
      
      #實際包裝數量
      LET l_inbb.inbb203 = l_inbb.inbb202 
      
      #計價單位、數量
      CALL s_aint911_get_inbb224('ALL',g_inba.inba012,l_inbb.inbb001)  
         RETURNING l_success,l_inbb.inbb224 
      IF NOT cl_null(l_inbb.inbb010) AND NOT cl_null(l_inbb.inbb011) AND NOT cl_null(l_inbb.inbb224) THEN
         CALL s_aooi250_convert_qty(l_inbb.inbb001,l_inbb.inbb010,l_inbb.inbb224,l_inbb.inbb011)
            RETURNING l_success,l_inbb.inbb225
         IF NOT l_success THEN
            LET r_success = FALSE
            EXIT FOREACH
         END IF 
         
         CALL s_aooi250_take_decimals(l_inbb.inbb224,l_inbb.inbb225)
            RETURNING l_success,l_inbb.inbb225                   
         IF NOT l_success THEN
            LET r_success = FALSE
            EXIT FOREACH
         END IF                                        
      END IF  
      
      
      #有效日期
      IF g_inba.inba208 = 'N' THEN
         LET l_inbb.inbb022 = g_inba.inbadocdt
      END IF
      IF NOT cl_null(l_inbb.inbb204) THEN
         LET l_success = '' 
         LET l_inbb022 = ''
         CALL s_lot_out_effdate(g_inbasite,
                                l_inbb.inbb001,l_inbb.inbb002,
                                l_inbb.inbb204,l_inbb.inbb009)
           RETURNING l_success,l_inbb022 
         IF l_success THEN
            LET l_inbb.inbb022 = l_inbb022
         END IF
      END IF   
            
      
      #進價
      LET l_success = ''
      LET l_rtdx034 = ''
      CALL s_cost_rtdx(g_inba.inbasite,l_inbb.inbb001,g_today,'')
         RETURNING l_success,l_rtdx034
      IF l_success THEN
         LET l_inbb.inbb210 = l_rtdx034
      END IF      

      #成本單價
      LET l_cost = 0   #160604-00009#140 Add By ken 160711
      IF (cl_null(g_inba.inba006) AND cl_null(l_inbb.inbb017)) OR cl_null(l_inbb.inbb211) OR cl_null(l_inbb.inbb212) THEN
      ELSE
         IF NOT cl_null(g_inba.inba006) THEN
            LET l_slip_no = g_inba.inba006
         ELSE
            IF NOT cl_null(l_inbb.inbb017) THEN 
               LET l_slip_no = l_inbb.inbb017
            END IF         
         END IF
         
         SELECT inbc206 
           INTO l_cost
           FROM inbc_t
          WHERE inbcent = g_enterprise
            AND inbcdocno = l_slip_no
            AND inbcseq = l_inbb.inbb211
            AND inbcseq1 = l_inbb.inbb212  
      END IF            
   
      IF cl_null(l_cost) OR l_cost = 0 THEN
         LET l_cost = l_inbb.inbb210
      END IF
      
      LET l_inbb.inbb207 = l_cost 
      IF NOT cl_null(l_inbb.inbb207) AND NOT cl_null(l_inbb.inbb012) THEN
         LET l_inbb.inbb208 = l_inbb.inbb207 * l_inbb.inbb012
      END IF      
                 
      INSERT INTO inbb_t(
      inbbent , inbbunit , inbbsite , inbbseq , inbbdocno ,    #企業編號 , 應用組織 , 營運據點 , 項次 , 單據編號
      inbb021 , inbb001 , inbb002 , inbb003 , inbb004 , inbb007 ,    #存貨備註 , 料件編號 , 產品特徵 , 庫存管理特徵 , 包裝容器編號 , 庫位
      inbb008 , inbb009 , inbb010 , inbb011 , inbb012 ,    #限定儲位 , 限定批號 , 交易單位 , 申請數量 , 實際異動數量
      inbb013 , inbb014 , inbb015 , inbb016 , inbb017 ,    #參考單位 , 參考單位申請數量 , 參考單位實際數量 , 理由碼 , 來源單號
      inbb018 , inbb019 , inbb020 , inbb022 ,    #檢驗否 , 檢驗合格量 , 單據備註 , 有效日期
      inbb023 , inbb024 , inbb025 , inbb200 , inbb201 ,    #專案編號 , WBS , 活動編號 , 商品條碼 , 包裝單位
      inbb202 , inbb203 , inbb204 , inbb205 , inbb206 ,    #申請包裝數量 , 實際包裝數量 , 製造日期 , 領用/退回單價 , 領用/退回金額
      inbb207 , inbb208 , inbb209 , inbb210 , inbb211 ,    #成本單價 , 成本金額 , 費用編號 , 進價 , 來源單據項次
      inbb212 , inbb224 , inbb225) 
      VALUES  (
      l_inbb.inbbent , l_inbb.inbbunit , l_inbb.inbbsite , l_inbb.inbbseq , l_inbb.inbbdocno , 
      l_inbb.inbb021 , l_inbb.inbb001  , l_inbb.inbb002  , l_inbb.inbb003 , l_inbb.inbb004 , l_inbb.inbb007 , 
      l_inbb.inbb008 , l_inbb.inbb009  , l_inbb.inbb010  , l_inbb.inbb011 , l_inbb.inbb012 , 
      l_inbb.inbb013 , l_inbb.inbb014  , l_inbb.inbb015  , l_inbb.inbb016 , l_inbb.inbb017 , 
      l_inbb.inbb018 , l_inbb.inbb019  , l_inbb.inbb020  , l_inbb.inbb022 , 
      l_inbb.inbb023 , l_inbb.inbb024  , l_inbb.inbb025  , l_inbb.inbb200 , l_inbb.inbb201 , 
      l_inbb.inbb202 , l_inbb.inbb203  , l_inbb.inbb204  , l_inbb.inbb205 , l_inbb.inbb206 , 
      l_inbb.inbb207 , l_inbb.inbb208  , l_inbb.inbb209  , l_inbb.inbb210 , l_inbb.inbb211 , 
      l_inbb.inbb212 , l_inbb.inbb224  , l_inbb.inbb225)
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins pmdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      IF NOT s_aint911_ins_inbc('1',l_inbb.inbbdocno,l_inbb.inbbseq) THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   
      INITIALIZE l_inbb.* TO NULL
      INITIALIZE l_imaa.* TO NULL
   END FOREACH
   
   IF r_success THEN
      CALL s_transaction_end('Y',0)
   ELSE
      CALL s_transaction_end('N',0)
   END IF
   CALL cl_err_collect_show()
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 單頭相關條件SQL語法
# Memo...........:
# Usage..........: CALL aint911_02_get_inba()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/6/27 By Ken #160604-00009#94
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_get_inba()
DEFINE l_sys             LIKE type_t.num5
DEFINE l_wc_tmp          STRING 

   CALL cl_get_para(g_enterprise,"","E-CIR-0055") RETURNING g_qty_sys   #160604-00009#140 Add By Ken 160711   

   INITIALIZE g_inba.* TO NULL
     
   SELECT inbadocdt, inbasite, inba015, inba203,
          inba205,   inba007,  inba208, inba006,  inba012
     INTO g_inba.inbadocdt, g_inba.inbasite, g_inba.inba015, g_inba.inba203,
          g_inba.inba205,   g_inba.inba007 , g_inba.inba208, g_inba.inba006,  g_inba.inba012
     FROM inba_t
    WHERE inbaent = g_enterprise
      AND inbadocno = g_inbadocno
    
    LET g_inag004_sql = ''
    LET g_imaa009_sql = ''
    
    IF NOT cl_null(g_inba.inba015) THEN
       LET g_inag004_sql = " AND inag004 = '",g_inba.inba015,"'"
    END IF
    
    IF NOT cl_null(g_inba.inba203) THEN
      LET l_sys = 0
      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      IF cl_null(g_where_sql) THEN
         LET g_imaa009_sql = " AND imaa009 IN (SELECT DISTINCT rtax001",
                                       "                FROM rtax_t ",
                                       "               WHERE rtaxent =",g_enterprise,
                                       "                 AND rtax004 >= ",l_sys,
                                       "                 AND rtaxstus = 'Y'",
                                       "               START WITH rtax003 = '",g_inba.inba203,"'",
                                       "             CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 ",
                                       "     UNION ",
                                       "    SELECT DISTINCT rtax001",
                                       "               FROM rtax_t ",
                                       "              WHERE rtaxent =",g_enterprise,
                                       "                AND rtax004 = ",l_sys,
                                       "                AND rtax005 = 0 ",
                                       "                AND rtaxstus = 'Y' ",
                                       "                AND rtax001 = '",g_inba.inba203,"')"       
      END IF                                   
    END IF    
      
END FUNCTION

################################################################################
# Descriptions...: 按查詢後把資料寫到tmp
# Memo...........:
# Usage..........: CALL aint911_02_gen_rtdx()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_gen_rtdx()
DEFINE l_sql             STRING
DEFINE l_where_sql       STRING
DEFINE l_success         LIKE type_t.num5
DEFINE l_ooba002         LIKE ooba_t.ooba002
DEFINE l_sys             LIKE type_t.num5 
DEFINE l_sys2            LIKE type_t.num5 
DEFINE l_inbbsite        LIKE inbb_t.inbbsite
DEFINE l_imaa            RECORD
       imaa001           LIKE imaa_t.imaa001,    #商品編號
       imaa014           LIKE imaa_t.imaa014,    #商品主條碼
       inbb202           LIKE inbb_t.inbb202,    #申請領用包裝數量
       inbb201           LIKE inbb_t.inbb201,    #申請領用包裝單位
       inbb011           LIKE inbb_t.inbb011,    #申請領用數量
       inbb010           LIKE inbb_t.inbb010,    #申請領用單位
       inag004           LIKE inag_t.inag004,    #庫位
       inag005           LIKE inag_t.inag005,    #儲位
       inag006           LIKE inag_t.inag006,    #批號
       inag009           LIKE inag_t.inag009                         
                         END RECORD 
DEFINE l_wc_tmp          STRING   

   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   DELETE FROM aint911_02_tmp
   
   LET l_where_sql = ''
   #所屬品類
   #IF NOT cl_null(l_imaa009) THEN
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF   
   
   IF g_wc2 != ' 1=1' THEN      
      LET l_sys = 0
      CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
      LET l_wc_tmp = ''
      LET l_wc_tmp = cl_replace_str(g_wc2,'imaa009','rtax003')
      LET l_where_sql = " AND imaa009 IN (SELECT DISTINCT rtax001",
                                    "                FROM rtax_t ",
                                    "               WHERE rtaxent =",g_enterprise,
                                    "                 AND rtax004 >= ",l_sys,
                                    "                 AND rtaxstus = 'Y'",
                                    "               START WITH ",l_wc_tmp,
                                    #"               START WITH rtax003 = '",l_imaa009,"'",
                                    "             CONNECT BY NOCYCLE PRIOR rtax001 = rtax003 "
      LET l_wc_tmp = ''
      LET l_wc_tmp = cl_replace_str(g_wc2,'imaa009','rtax001')      
      LET l_where_sql = l_where_sql ,
                                    "     UNION ",
                                    "    SELECT DISTINCT rtax001",
                                    "               FROM rtax_t ",
                                    "              WHERE rtaxent =",g_enterprise,
                                    "                AND rtax004 = ",l_sys,
                                    "                AND rtax005 = 0 ",
                                    "                AND rtaxstus = 'Y' ",
                                    "                AND ",l_wc_tmp,")"                                    
   END IF   

   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Del aint911_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   LET l_sql = "INSERT INTO aint911_02_tmp(sel         ,       imaa001      ,       imaa014      ,       inbb202      ,       inbb201, ",
               "                           inbb011     ,       inbb010      ,       inag004      ,       inag005      ,       inag006, ",
               "                           inag009      ) ",
               "                    SELECT 'N',                imaa001,             imaa014,             0,                   rtdx004, ",
               "                           0,                  imaa006,             inag004,             '',                  '', ",
               "                           SUM(inag008) ",
               "                     FROM  inag_t ",
               #"                                  LEFT JOIN inaa_t ON inaaent = inagent AND inaasite = inagsite AND inag004 = inaa001 ",
               "                                  LEFT JOIN inayl_t ON inaylent = inagent  AND inayl001 = inag004   AND inayl002 = '",g_dlang,"' ,",
               #"                                  LEFT JOIN inab_t ON inabent = inagent AND inabsite = inagsite AND inab001 = inag004 AND inab002 = inag005, ",
               "                           imaa_t ",
               "                                  LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"' ,",
               "                           rtdx_t ",
               "                     WHERE inagent = imaaent AND inag001 = imaa001 ",
               "                       AND inagent = rtdxent AND inagsite = rtdxsite AND inag001 = rtdx001 ",
               "                       AND inagent  =",g_enterprise,
               "                       AND inagsite = '",g_inbasite,"'",
               "                       AND rtdxstus ='Y' ",
               "                       AND imaastus ='Y' "              
   IF cl_null(g_inag004_sql) THEN
     LET l_sql = l_sql ," AND ",g_wc
   ELSE
     LET l_sql = l_sql , g_inag004_sql
   END IF
   IF cl_null(g_imaa009_sql) THEN
     LET l_sql = l_sql , l_where_sql     
   ELSE
      LET l_sql = l_sql ,g_imaa009_sql
   END IF
   LET l_sql = l_sql ," GROUP BY imaa001,imaa014,rtdx004,imaa006,inag004  "
   LET l_sql = l_sql ," ORDER BY imaa001,inag004  "
   
   DISPLAY ' QBE SQL = ',l_sql
   
   PREPARE aint911_02_ins_tmp FROM l_sql
   EXECUTE aint911_02_ins_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Ins aint911_02_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   ##營運據點
   ##單頭需求組織(pmda203)非空白時，Default = 需求組織(pmda203)
   #IF NOT cl_null(g_pmda.pmda203) THEN
   #   LET l_pmdbsite = g_pmda.pmda203
   #ELSE
   #   LET l_pmdbsite = g_site
   #END IF   
   
   #CALL cl_get_para(g_enterprise,g_pmdasite,'S-CIR-1001') RETURNING l_sys  
   #   
   #LET l_sql = "SELECT DISTINCT rtdx001,rtdx002",
   #            "  FROM aint911_02_tmp"
   #            
   #INITIALIZE l_rtdx.* TO NULL               
   #PREPARE apmt830_sel_imaz_pre FROM l_sql
   #DECLARE apmt830_sel_imaz_cs CURSOR FOR apmt830_sel_imaz_pre
   #FOREACH apmt830_sel_imaz_cs INTO l_rtdx.rtdx001,l_rtdx.rtdx002
   #    
   #    
   #   #150710-00016#4 Add By Ken 150713(S) 取商品符合補貨規格的包裝單位、件裝數、補貨規格
   #   ##補貨條碼、包裝單位       
   #   #SELECT imaz003,imaz004 INTO l_rtdx.imaz003,l_rtdx.rtdx004
   #   #  FROM imaz_t
   #   # WHERE imazent = g_enterprise
   #   #   AND imaz001 = l_rtdx.rtdx001
   #   #
   #   #IF NOT cl_null(l_rtdx.imaz003) THEN
   #   #   UPDATE aint911_02_tmp
   #   #      SET imaz003 = l_rtdx.imaz003,
   #   #          rtdx004 = l_rtdx.rtdx004
   #   #    WHERE rtdx001 = l_rtdx.rtdx001
   #   #      AND rtdx002 = l_rtdx.rtdx002                      
   #   #END IF
   #              
   #
   #   LET l_rtdx.rtdx004 = ''
   #   LET l_rtdx.imaz006 = ''
   #   CALL cl_get_para(g_enterprise,g_pmdasite,'S-CIR-1001') RETURNING l_sys2
   #   SELECT imaz004,imaz006 INTO l_rtdx.rtdx004,l_rtdx.imaz006
   #     FROM imaz_t
   #    WHERE imazent = g_enterprise 
   #      AND imaz001 = l_rtdx.rtdx001
   #      AND imaz002 = l_sys2   
   #      
   #    IF cl_null(l_rtdx.rtdx004) THEN
   #       SELECT imay004 
   #         INTO l_rtdx.rtdx004
   #         FROM imay_t 
   #        WHERE imayent= g_enterprise 
   #          AND imay001 = l_rtdx.rtdx001 
   #          AND imay003 = l_rtdx.rtdx002  
   #    END IF         
   #      
   #    UPDATE aint911_02_tmp
   #       SET rtdx004 = l_rtdx.rtdx004,
   #           imaz006 = l_rtdx.imaz006
   #     WHERE rtdx001 = l_rtdx.rtdx001
   #       AND rtdx002 = l_rtdx.rtdx002         
   #   #150710-00016#4 Add By Ken 150713(E)       
   #   
   #   #可用庫存量
   #   CALL s_apmt840_sum_inag008(l_pmdbsite,l_rtdx.rtdx001,' ') 
   #      RETURNING l_rtdx.pmdb252
   #
   #   #前一週銷量
   #   CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,1,7,l_rtdx.rtdx001,' ')
   #      RETURNING l_rtdx.pmdb254
   #   
   #   #前二週銷量
   #   CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,8,14,l_rtdx.rtdx001,' ')
   #      RETURNING l_rtdx.pmdb255
   #      
   #   #前三週銷量
   #   CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,15,21,l_rtdx.rtdx001,' ')
   #      RETURNING l_rtdx.pmdb256
   #      
   #   #前四周銷量
   #   CALL s_daily_sale(l_pmdbsite,g_pmdadocdt,22,28,l_rtdx.rtdx001,' ')
   #      RETURNING l_rtdx.pmdb257
   #   
   #   #要貨在途量
   #   CALL s_apmt830_sum_pmdb258(l_pmdbsite,l_rtdx.rtdx001,' ')
   #      RETURNING l_rtdx.pmdb258
   #   
   #   #週平均銷量
   #   LET l_rtdx.pmdb259 = (l_rtdx.pmdb254 + l_rtdx.pmdb255 + l_rtdx.pmdb256 + l_rtdx.pmdb257)/4
   #        
   #   UPDATE aint911_02_tmp
   #      SET pmdb252 = l_rtdx.pmdb252,
   #          pmdb254 = l_rtdx.pmdb254,
   #          pmdb255 = l_rtdx.pmdb255,
   #          pmdb256 = l_rtdx.pmdb256,
   #          pmdb257 = l_rtdx.pmdb257,
   #          pmdb258 = l_rtdx.pmdb258,
   #          pmdb259 = l_rtdx.pmdb259
   #    WHERE rtdx001 = l_rtdx.rtdx001
   #      AND rtdx002 = l_rtdx.rtdx002      
   #END FOREACH
   
   CALL aint911_02_b_fill()
   
   LET g_rec_b = g_imaa_d.getLength()
   IF g_rec_b = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01321'  #apm-00294   #160318-00005#38  By 07900--mod
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 全選
# Memo...........:
# Usage..........: CALL aint911_02_check_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_check_all()
   UPDATE aint911_02_tmp SET sel = 'Y'
   CALL aint911_02_set_entry_b("a")
   CALL aint911_02_set_no_entry_b("a")    
   CALL aint911_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 全不選
# Memo...........:
# Usage..........: CALL aint911_02_check_no_all()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_check_no_all()
   UPDATE aint911_02_tmp SET sel = 'N'
   CALL aint911_02_set_entry_b("a")
   CALL aint911_02_set_no_entry_b("a")    
   CALL aint911_02_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 單位間的轉換數量
# Memo...........: 當要貨數量為空，由要貨包裝數量轉換成要貨數量及計價數量
#                : 當要貨數量有值，由要貨數量轉換成要貨包裝數量及計價數量
# Usage..........: CALL aint911_02_num_change()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/05/27 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_num_change()
DEFINE l_success        LIKE type_t.num5

   #當要貨包裝單位或要貨單位都為空，表示無法轉換
   IF cl_null(g_imaa_d[l_ac].l_inbb201) OR cl_null(g_imaa_d[l_ac].l_inbb010) THEN
      RETURN
   END IF
   
   CASE
      WHEN INFIELD (l_inbb011)
         CALL s_aooi250_convert_qty(g_imaa_d[l_ac].imaa001,g_imaa_d[l_ac].l_inbb010,g_imaa_d[l_ac].l_inbb201,g_imaa_d[l_ac].l_inbb011)
            RETURNING l_success,g_imaa_d[l_ac].l_inbb202
         CALL s_aooi250_take_decimals(g_imaa_d[l_ac].l_inbb201,g_imaa_d[l_ac].l_inbb202)
            RETURNING l_success,g_imaa_d[l_ac].l_inbb202             
      WHEN INFIELD (l_inbb202)
         CALL s_aooi250_convert_qty(g_imaa_d[l_ac].imaa001,g_imaa_d[l_ac].l_inbb201,g_imaa_d[l_ac].l_inbb010,g_imaa_d[l_ac].l_inbb202)
            RETURNING l_success,g_imaa_d[l_ac].l_inbb011
         CALL s_aooi250_take_decimals(g_imaa_d[l_ac].l_inbb010,g_imaa_d[l_ac].l_inbb011)
            RETURNING l_success,g_imaa_d[l_ac].l_inbb011
      OTHERWISE
         IF cl_null(g_imaa_d[l_ac].l_inbb011) OR g_imaa_d[l_ac].l_inbb011 = 0 THEN
            CALL s_aooi250_convert_qty(g_imaa_d[l_ac].imaa001,g_imaa_d[l_ac].l_inbb201,g_imaa_d[l_ac].l_inbb010,g_imaa_d[l_ac].l_inbb202)
               RETURNING l_success,g_imaa_d[l_ac].l_inbb011
         ELSE
            CALL s_aooi250_convert_qty(g_imaa_d[l_ac].imaa001,g_imaa_d[l_ac].l_inbb010,g_imaa_d[l_ac].l_inbb201,g_imaa_d[l_ac].l_inbb011)
               RETURNING l_success,g_imaa_d[l_ac].l_inbb202
         END IF
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 更新tmp中的領用數量、領用包裝數量
# Memo...........:
# Usage..........: CALL aint911_02_inbb011_upd()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/06/27 By Ken   #160604-00009#94
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_inbb011_upd()
DEFINE l_sel   LIKE type_t.chr1

   IF g_imaa_d[l_ac].l_inbb011 > 0 OR g_imaa_d[l_ac].l_inbb202 > 0 THEN
      LET l_sel = 'Y'
   ELSE
      LET l_sel = 'N'
   END IF
   
   UPDATE aint911_02_tmp 
      SET inbb011 = g_imaa_d[l_ac].l_inbb011,
          inbb202 = g_imaa_d[l_ac].l_inbb202,
          sel = l_sel
    WHERE imaa001 = g_imaa_d[l_ac].imaa001
      AND inag004 = g_imaa_d[l_ac].inag004
     # AND inag005 = g_imaa_d[l_ac].inag005
     # AND inag006 = g_imaa_d[l_ac].inag006
END FUNCTION

################################################################################
# Descriptions...: 如果aoos010参数E-CIR-0055设置为N，录入数量的时候，判断，不能大于库存数量
# Memo...........:
# Usage..........: CALL aint911_02_num_chk(p_inbb011,p_inag009)
#                  RETURNING r_success
# Input parameter: p_inbb011      領用數量
#                : p_inag009      庫存數量
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/07/11 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION aint911_02_num_chk(p_inbb011,p_inag009)
DEFINE p_inbb011        LIKE inbb_t.inbb011
DEFINE p_inag009        LIKE inag_t.inag009
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   IF cl_null(p_inbb011) THEN
      LET p_inbb011 = 0
   END IF
   
   IF cl_null(p_inag009) THEN
      LET p_inag009 = 0
   END IF   
   
   IF g_qty_sys = 'N' AND (p_inbb011 > p_inag009 ) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ain-00765'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_inbb011
      LET g_errparam.replace[2] = p_inag009     
      CALL cl_err()       
      LET r_success = FALSE
   END IF   
   
   RETURN r_success 
END FUNCTION

 
{</section>}
 

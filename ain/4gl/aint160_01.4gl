#該程式未解開Section, 採用最新樣板產出!
{<section id="aint160_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-03-12 11:36:14), PR版次:0007(2016-12-09 16:15:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000151
#+ Filename...: aint160_01
#+ Description: 整批產生庫存留置單身子作業
#+ Creator....: 01258(2014-03-30 21:47:22)
#+ Modifier...: 05423 -SD/PR- 08734
 
{</section>}
 
{<section id="aint160_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160315-00026#1 by xujing 16/03/16 整单操作中的整批产生库存留置单身子作业的“产品特征”,根据参数管控是否显示
#160705-00042#7 2016/07/15  By 02159    把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#161124-00048#4 2016/12/09  By 08734    星号整批调整
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
 
{<section id="aint160_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_inbe008         LIKE inbe_t.inbe008
DEFINE g_inbe_d          DYNAMIC ARRAY OF RECORD
       l_choice          LIKE type_t.chr1,
       l_inbe001         LIKE inbe_t.inbe001,
       l_inbe001_desc    LIKE imaal_t.imaal003,
       l_inbe001_desc_desc  LIKE imaal_t.imaal004,
       l_inbe002         LIKE inbe_t.inbe002,
       l_inbe003         LIKE inbe_t.inbe003,
       l_inbe007         LIKE inbe_t.inbe007,
       l_inbe007_desc    LIKE oocal_t.oocal003,
       l_inbe004         LIKE inbe_t.inbe004,
       l_inbe004_desc    LIKE inaa_t.inaa002,
       l_inbe005         LIKE inbe_t.inbe005,
       l_inbe005_desc    LIKE inab_t.inab003,
       l_inbe006         LIKE inbe_t.inbe006
                         END RECORD
DEFINE l_ac              LIKE type_t.num5
DEFINE g_rec_b           LIKE type_t.num5
DEFINE g_inbedocno       LIKE inbe_t.inbedocno
DEFINE g_acc             LIKE gzcb_t.gzcb007
DEFINE g_wc              STRING
DEFINE g_sql             STRING
DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
{</section>}
 
{<section id="aint160_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aint160_01.other_dialog" >}

 
{</section>}
 
{<section id="aint160_01.other_function" readonly="Y" >}

PUBLIC FUNCTION aint160_01(--)
   #add-point:input段變數傳入
   p_inbedocno
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define
   DEFINE p_inbedocno     LIKE inbe_t.inbedocno
   #DEFINE l_inbe          RECORD LIKE inbe_t.*  #161124-00048#4  2016/12/09 By 08734 mark
   #161124-00048#4  2016/12/09 By 08734 add(S)
   DEFINE l_inbe RECORD  #庫存留置作業明細檔
       inbeent LIKE inbe_t.inbeent, #企业编号
       inbesite LIKE inbe_t.inbesite, #营运据点
       inbedocno LIKE inbe_t.inbedocno, #单据编号
       inbeseq LIKE inbe_t.inbeseq, #项次
       inbe001 LIKE inbe_t.inbe001, #料件编号
       inbe002 LIKE inbe_t.inbe002, #产品特征
       inbe003 LIKE inbe_t.inbe003, #库存管理特征
       inbe004 LIKE inbe_t.inbe004, #库位
       inbe005 LIKE inbe_t.inbe005, #储位
       inbe006 LIKE inbe_t.inbe006, #批号
       inbe007 LIKE inbe_t.inbe007, #库存单位
       inbe008 LIKE inbe_t.inbe008, #原因码
       inbe009 LIKE inbe_t.inbe009 #备注
END RECORD
#161124-00048#4  2016/12/09 By 08734 add(E)
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_flag1         LIKE type_t.chr1
   #end add-poin

   IF cl_null(p_inbedocno) THEN
      RETURN
   END IF
   LET g_inbedocno = p_inbedocno
   #畫面開啟 (identifier)
   OPEN WINDOW w_aint160_01 WITH FORM cl_ap_formpath("ain","aint160_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #160315-00026#1(s)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN 
      CALL cl_set_comp_visible("inag002,l_inbe002",FALSE)
   END IF
   #160315-00026#1(e)
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint160'                            #160705-00042#7 160715 by sakura mark
   SELECT gzcb004 INTO g_acc FROM gzcb_t,gzzz_t WHERE gzcb001 = '24' AND gzcb002 = gzzz006 AND gzzz001 = g_prog   #160705-00042#7 160715 by sakura add

   LET g_qryparam.state = "i"
   LET p_cmd = 'a'

   #輸入前處理
   #add-point:單頭前置處理
   CLEAR FORM
   CALL g_inbe_d.clear()
   LET g_inbe008 = NULL
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      CONSTRUCT BY NAME g_wc ON inag001,inag002,inag003,inag007,inag004,inag005,inag006
      
         ON ACTION controlp INFIELD inag001          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag001      #顯示到畫面上
            NEXT FIELD inag001                         #返回原欄位
            
         ON ACTION controlp INFIELD inag002          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag002      #顯示到畫面上
            NEXT FIELD inag002                         #返回原欄位
            
         ON ACTION controlp INFIELD inag003          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag003      #顯示到畫面上
            NEXT FIELD inag003                         #返回原欄位
            
         ON ACTION controlp INFIELD inag004          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag004_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag004      #顯示到畫面上
            NEXT FIELD inag004                         #返回原欄位
            
         ON ACTION controlp INFIELD inag005          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag005      #顯示到畫面上
            NEXT FIELD inag005                         #返回原欄位
            
         ON ACTION controlp INFIELD inag006          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag006      #顯示到畫面上
            NEXT FIELD inag006                         #返回原欄位
            
         ON ACTION controlp INFIELD inag007          
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag007      #顯示到畫面上
            NEXT FIELD inag007                         #返回原欄位
            
         AFTER CONSTRUCT
            LET l_flag1 = 'N'
            
      END CONSTRUCT
      
      #輸入開始
      INPUT g_inbe008 FROM inbe008 ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION
         #add-point:單頭前置處理

         #end add-point

         #自訂ACTION(master_input)


         BEFORE INPUT
            #add-point:單頭輸入前處理

            #end add-point

         #----<<inbe008>>----
         #此段落由子樣板a02產生
         AFTER FIELD inbe008

            #add-point:AFTER FIELD inbe008
            IF NOT cl_null(g_inbe008) THEN
               CALL s_azzi650_chk_exist(g_acc,g_inbe008) RETURNING l_success
               IF NOT l_success THEN
                   NEXT FIELD inbe008
               END IF
             
               #檢核輸入的理由碼是否在單據別限制範圍內，若不在限制內則不允許使用此理由碼
               CALL s_control_chk_doc('8',g_inbedocno,g_inbe008,'','','','') RETURNING l_success,l_flag
               IF NOT l_success THEN
                  NEXT FIELD inbe008
               ELSE
                  IF NOT l_flag THEN
                     NEXT FIELD inbe008
                  END IF
               END IF
            END IF

            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD inbe008
            #add-point:BEFORE FIELD inbe008
          
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE inbe008
            #add-point:ON CHANGE inbe008

            #END add-point


         #----<<inbe008>>----
         #Ctrlp:input.c.inbe008
         ON ACTION controlp INFIELD inbe008
            #add-point:ON ACTION controlp INFIELD inbe008
            #此段落由子樣板a07產生
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbe008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_acc


            CALL q_oocq002()                                #呼叫開窗

            LET g_inbe008 = g_qryparam.return1

            DISPLAY g_inbe008 TO inbe008              #

            NEXT FIELD inbe008                          #返回原欄位


            #END add-point

 #欄位開窗

         AFTER INPUT
            #add-point:單頭輸入後處理
#            IF INT_FLAG THEN
#               EXIT DIALOG
#            END IF
#            CALL aint160_01_b_fill()
#            IF g_rec_b = 0 THEN              
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = -100
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               NEXT FIELD inag001
#            ELSE
#               LET l_flag1 = 'Y'
#            END IF
            #end add-point

      END INPUT

      #add-point:自定義input
#      INPUT ARRAY g_inbe_d FROM s_detail1.*
#          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_rec_b,WITHOUT DEFAULTS, 
#                  INSERT ROW = FALSE,
#                  DELETE ROW = FALSE,
#                  APPEND ROW = FALSE)
#         BEFORE INPUT 
#            LET l_flag1 = 'P'
#         
#         BEFORE ROW
#            LET l_ac = ARR_CURR()
#            DISPLAY l_ac TO FORMONLY.h_index  
#            
#         AFTER INPUT
#            IF INT_FLAG THEN
#               EXIT DIALOG
#            END IF  
#      END INPUT 
      #end add-point

      AFTER DIALOG
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            CALL aint160_01_b_fill()
            IF g_rec_b = 0 THEN              
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -100
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD inag001
            ELSE
               LET l_flag1 = 'Y'
            END IF
         #输入完单头后点确定后强制进入单身
#         IF l_flag1 = 'N' AND INT_FLAG = FALSE THEN
#            NEXT FIELD inbe008
#         END IF
#         
#         IF l_flag1 = 'Y' AND INT_FLAG = FALSE THEN
#            NEXT FIELD l_choice
#         END IF
      
#      ON ACTION all_select
#         FOR l_i = 1 TO g_rec_b
#            LET g_inbe_d[l_i].l_choice = 'Y'
#         END FOR
#
#      ON ACTION not_select
#         FOR l_i = 1 TO g_rec_b
#            LET g_inbe_d[l_i].l_choice = 'N'
#         END FOR
         
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
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_aint160_01
      RETURN 
   END IF
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         INPUT ARRAY g_inbe_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_rec_b,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         BEFORE INPUT 
            LET l_flag1 = 'P'
         
         BEFORE ROW
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.h_index  
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF  
      END INPUT 
      
      ON ACTION all_select
         FOR l_i = 1 TO g_rec_b
            LET g_inbe_d[l_i].l_choice = 'Y'
         END FOR

      ON ACTION not_select
         FOR l_i = 1 TO g_rec_b
            LET g_inbe_d[l_i].l_choice = 'N'
         END FOR
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
   END DIALOG
   #add-point:畫面關閉前
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_aint160_01
      RETURN 
   END IF
   #end add-point
   IF cl_null(g_inbe008) THEN
      SELECT inbd005 INTO g_inbe008 FROM inbd_t WHERE inbdent=g_enterprise AND inbdsite=g_site AND inbddocno=g_inbedocno
   END IF
   
   FOR l_i = 1 TO g_rec_b
      IF g_inbe_d[l_i].l_choice = 'N' THEN
         CONTINUE FOR
      END IF
      INITIALIZE l_inbe.* TO NULL
      LET l_inbe.inbeent = g_enterprise
      LET l_inbe.inbesite = g_site
      LET l_inbe.inbedocno = g_inbedocno
      SELECT MAX(inbeseq)+1 INTO l_inbe.inbeseq FROM inbe_t WHERE inbeent=g_enterprise AND inbesite=g_site AND inbedocno=g_inbedocno
      IF cl_null(l_inbe.inbeseq) THEN 
         LET l_inbe.inbeseq = 1
      END IF
      LET l_inbe.inbe001 = g_inbe_d[l_i].l_inbe001
      LET l_inbe.inbe002 = g_inbe_d[l_i].l_inbe002
      LET l_inbe.inbe003 = g_inbe_d[l_i].l_inbe003
      LET l_inbe.inbe004 = g_inbe_d[l_i].l_inbe004
      LET l_inbe.inbe005 = g_inbe_d[l_i].l_inbe005
      LET l_inbe.inbe006 = g_inbe_d[l_i].l_inbe006
      LET l_inbe.inbe007 = g_inbe_d[l_i].l_inbe007
      LET l_inbe.inbe008 = g_inbe008
      #INSERT INTO inbe_t VALUES l_inbe.*  #161124-00048#4  2016/12/09 By 08734 mark
      INSERT INTO inbe_t(inbeent,inbesite,inbedocno,inbeseq,inbe001,inbe002,inbe003,inbe004,inbe005,inbe006,inbe007,inbe008,inbe009)
         VALUES (l_inbe.inbeent,l_inbe.inbesite,l_inbe.inbedocno,l_inbe.inbeseq,l_inbe.inbe001,l_inbe.inbe002,l_inbe.inbe003,l_inbe.inbe004,l_inbe.inbe005,l_inbe.inbe006,l_inbe.inbe007,l_inbe.inbe008,l_inbe.inbe009)  #161124-00048#4  2016/12/09 By 08734 add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins inbe_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         CLOSE WINDOW w_aint160_01
         RETURN
      END IF
   END FOR
      
   #畫面關閉
   CLOSE WINDOW w_aint160_01

   #add-point:input段after input
   LET g_inbe008 = NULL
   #end add-point

END FUNCTION
#根据查询条件 显示单身
PRIVATE FUNCTION aint160_01_b_fill()
   LET g_sql = "SELECT 'N',inag001,'','',inag002,inag003,inag007,'',inag004,'',inag005,'',inag006 FROM inag_t  ",
               " WHERE inagent=",g_enterprise," AND inagsite='",g_site,"' AND inag019='N' AND inag008 >0"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   LET g_sql = g_sql," AND ",g_wc
   PREPARE aint160_01_pre FROM g_sql
   DECLARE aint160_01_cs CURSOR FOR aint160_01_pre
   CALL g_inbe_d.clear()
   LET l_ac = 1
   FOREACH aint160_01_cs INTO g_inbe_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      IF NOT aint160_01_control_chk(g_inbe_d[l_ac].l_inbe001,g_inbe_d[l_ac].l_inbe004,g_inbe_d[l_ac].l_inbe005) THEN
         CONTINUE FOREACH
      END IF
      CALL aint160_01_b_desc()
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_inbe_d.deleteElement(l_ac)
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.h_count
   FREE aint160_01_pre
END FUNCTION

################################################################################
# Descriptions...: 檢查單別對料件生命週期、產品分類、庫位、儲位的設置
# Date & Author..: 2014/04/22 By chenjing
# Modify.........:
################################################################################
PRIVATE FUNCTION aint160_01_control_chk(p_inbe001,p_inbe004,p_inbe005)
   DEFINE p_inbe001   LIKE inbe_t.inbe001
   DEFINE p_inbe004   LIKE inbe_t.inbe004
   DEFINE p_inbe005   LIKE inbe_t.inbe005
   DEFINE l_sql       STRING
   DEFINE l_sql1      STRING
   DEFINE l_ooef004   LIKE ooef_t.ooef004
   DEFINE l_doc       LIKE ooba_t.ooba002
   DEFINE l_success   LIKE type_t.num5
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_flag      LIKE type_t.num5
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_n1        LIKE type_t.num5
   DEFINE l_imaf016   LIKE imaf_t.imaf016
   DEFINE l_imaa009   LIKE imaa_t.imaa009
   DEFINE l_ooba008   LIKE ooba_t.ooba008
   DEFINE l_ooba009   LIKE ooba_t.ooba009
   DEFINE l_ooba010   LIKE ooba_t.ooba010
   DEFINE l_ooba011   LIKE ooba_t.ooba011
   DEFINE l_ooba012   LIKE ooba_t.ooba012
   DEFINE l_ooba014   LIKE ooba_t.ooba014
   DEFINE l_inaa008   LIKE inaa_t.inaa008
   DEFINE l_inaa009   LIKE inaa_t.inaa009
   DEFINE l_inaa010   LIKE inaa_t.inaa010
   DEFINE l_inac003   LIKE inac_t.inac003
   
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   CALL s_aooi200_get_slip(g_inbedocno) RETURNING l_success,l_doc
   LET r_success = TRUE
   LET l_n = 0
   IF NOT cl_null(p_inbe001) THEN
      #检核产品生命周期资料是否在單別控制范围内
      LET l_sql = "SELECT COUNT(oobd003) FROM ooba_t,oobd_t WHERE oobaent=oobdent AND ooba001=oobd001 AND ooba002=oobd002",
                   "   AND oobaent = ",g_enterprise," AND ooba001 = '",l_ooef004,"' AND ooba002 = '",l_doc,"' AND oobd003='210'"
      PREPARE doc_pre4 FROM l_sql
      EXECUTE doc_pre4 INTO l_n
      IF l_n > 0 THEN
         SELECT imaf016 INTO l_imaf016 FROM imaf_t WHERE imafent = g_enterprise AND imaf001 = p_inbe001 AND imafsite = g_site
         LET l_sql = l_sql," AND oobd004 = '",l_imaf016,"'"
         PREPARE doc_pre4_1 FROM l_sql
         EXECUTE doc_pre4_1 INTO l_n
         IF l_n = 0 THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF 
      
      #检核产品分类资料是否在單別控制范围内
      LET l_sql = "SELECT COUNT(oobh003) FROM ooba_t,oobh_t WHERE oobaent=oobhent AND ooba001=oobh001 AND ooba002=oobh002",
                  "   AND oobaent = ",g_enterprise," AND ooba001 = '",l_ooef004,"' AND ooba002 = '",l_doc,"'"
      PREPARE doc_pre5 FROM l_sql
      EXECUTE doc_pre5 INTO l_n
      IF l_n >0 THEN      
         SELECT imaa009 INTO l_imaa009 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_inbe001
         SELECT ooba014 INTO l_ooba014 FROM ooba_t WHERE oobaent = g_enterprise AND ooba001 = l_ooef004 AND ooba002 = l_doc
         LET l_sql = l_sql," AND oobh003 = '",l_imaa009,"'"
         PREPARE doc_pre5_1 FROM l_sql
         EXECUTE doc_pre5_1 INTO l_n
         IF l_n > 0 THEN 
            IF l_ooba014 = '2' THEN
               LET r_success = FALSE
               RETURN r_success
            END IF 
         ELSE
            IF l_ooba014 = '1' THEN 
               LET r_success = FALSE
               RETURN r_success
            END IF 
         END IF
      END IF       
   END IF
   #检核库位(From)资料是否在控制范围内
   IF cl_null(p_inbe005) THEN
      LET p_inbe005 = ' ' 
   END IF 
   IF NOT cl_null(p_inbe004) AND p_inbe005 IS NOT NULL THEN
      SELECT ooba008,ooba010,ooba012 INTO l_ooba008,l_ooba010,l_ooba012 FROM ooba_t
       WHERE oobaent=g_enterprise AND ooba001=l_ooef004 AND ooba002=l_doc 
      LET l_sql = "SELECT COUNT(oobj003) FROM ooba_t,oobj_t WHERE oobaent=oobjent AND ooba001=oobj001 AND ooba002=oobj002",
                  "   AND oobaent = ",g_enterprise," AND ooba001 = '",l_ooef004,"' AND ooba002 = '",l_doc,"'"
      PREPARE doc_pre6 FROM l_sql
      EXECUTE doc_pre6 INTO l_n
      IF cl_null(l_ooba008) AND cl_null(l_ooba010) AND cl_null(l_ooba012) THEN
      ELSE
         SELECT inaa008,inaa009,inaa010 INTO l_inaa008,l_inaa009,l_inaa010 FROM inaa_t
          WHERE inaaent = g_enterprise AND inaasite=g_site AND  inaa001=p_inbe004
         IF NOT cl_null(l_ooba008) AND l_ooba008 != l_inaa008 THEN 
            LET r_success = FALSE
            RETURN r_success
         END IF 
         IF NOT cl_null(l_ooba010) AND l_ooba010 != l_inaa009 THEN 
            LET r_success = FALSE 
            RETURN r_success
         END IF
         IF NOT cl_null(l_ooba012) AND l_ooba012 != l_inaa010 THEN 
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         LET l_sql1 = "SELECT oobj003 FROM ooba_t,oobj_t WHERE oobaent=oobjent AND ooba001=oobj001 AND ooba002=oobj002",
                  "   AND oobaent = ",g_enterprise," AND ooba001 = '",l_ooef004,"' AND ooba002 = '",l_doc,"'"
         PREPARE doc_pre6_1 FROM l_sql1
         DECLARE doc_cs6 CURSOR FOR doc_pre6_1
         LET l_flag = TRUE
         FOREACH doc_cs6 INTO l_inac003
            LET l_flag = FALSE
            SELECT COUNT(inac003) INTO l_n1 FROM inac_t WHERE inacent=g_enterprise AND inacsite=g_site
               AND inac001=p_inbe004 AND inac002=p_inbe005 AND inac003=l_inac003
            IF l_n1 > 0 THEN
               EXIT FOREACH
            END IF 
         END FOREACH
         IF l_flag OR l_n1 > 0 THEN
         ELSE
            LET r_success = FALSE
            RETURN r_success
         END IF 
      END IF   
   END IF
   RETURN r_success
END FUNCTION
#单身ref显示
PRIVATE FUNCTION aint160_01_b_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbe_d[l_ac].l_inbe001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbe_d[l_ac].l_inbe001_desc = '', g_rtn_fields[1] , ''
   LET g_inbe_d[l_ac].l_inbe001_desc_desc = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inbe_d[l_ac].l_inbe001_desc,g_inbe_d[l_ac].l_inbe001_desc_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbe_d[l_ac].l_inbe007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbe_d[l_ac].l_inbe007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_inbe_d[l_ac].l_inbe007_desc
   
   LET g_inbe_d[l_ac].l_inbe004_desc = s_desc_get_stock_desc(g_site,g_inbe_d[l_ac].l_inbe004)
   
   LET g_inbe_d[l_ac].l_inbe005_desc = s_desc_get_locator_desc(g_site,g_inbe_d[l_ac].l_inbe004,g_inbe_d[l_ac].l_inbe005) 
   
 # INITIALIZE g_ref_fields TO NULL
 # LET g_ref_fields[1] = g_inbe_d[l_ac].l_inbe008
 # CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001= '"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
 # LET g_inbe_d[l_ac].l_inbe008_desc = '', g_rtn_fields[1] , ''
 # DISPLAY BY NAME g_inbe_d[l_ac].l_inbe008_desc
END FUNCTION

 
{</section>}
 

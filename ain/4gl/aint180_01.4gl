#該程式未解開Section, 採用最新樣板產出!
{<section id="aint180_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-03-20 11:02:34), PR版次:0004(2016-12-09 18:21:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000058
#+ Filename...: aint180_01
#+ Description: 整批產生變更明細子作業
#+ Creator....: 05423(2015-03-12 11:10:09)
#+ Modifier...: 05423 -SD/PR- 08734
 
{</section>}
 
{<section id="aint180_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160705-00042#7   2016/07/15  By 02159    把gzcb002=固定寫死的作業代號改成g_prog,然後gzcb_t要多JOIN gzzz_t
#161124-00048#5   2016/12/09  By 08734    星号整批调整
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
 
{<section id="aint180_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
 type type_master        RECORD
   inag001 LIKE inag_t.inag001, 
   inag002 LIKE inag_t.inag002, 
   imaa009 LIKE imaa_t.imaa009, 
   inad011 LIKE inad_t.inad011, 
   inag004 LIKE inag_t.inag004, 
   inag005 LIKE inag_t.inag005, 
   inag006 LIKE inag_t.inag006, 
   imaf052 LIKE imaf_t.imaf052, 
   l_type LIKE type_t.chr500, 
   l_upddate LIKE inad_t.inad011, 
   l_month LIKE type_t.num5, 
   l_day LIKE type_t.num5
END RECORD
 
#單身 type 宣告
 TYPE type_g_inbl_d        RECORD
   l_choice LIKE type_t.chr500, 
   inbl001 LIKE inbl_t.inbl001, 
   inbl001_desc LIKE type_t.chr500, 
   inbl001_desc_1 LIKE type_t.chr500, 
   inbl002 LIKE inbl_t.inbl002, 
   l_inbl002_desc LIKE type_t.chr500, 
   inbl003 LIKE inbl_t.inbl003, 
   inbl006 LIKE inbl_t.inbl006, 
   inbl007 LIKE inbl_t.inbl007, 
   inbl008 LIKE inbl_t.inbl008, 
   inbl008_desc LIKE type_t.chr500
 END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master          type_master
 
DEFINE g_inbl_d          DYNAMIC ARRAY OF type_g_inbl_d
DEFINE g_inbl_d_t        type_g_inbl_d
DEFINE g_inbl_d_o        type_g_inbl_d
 
DEFINE g_wc                  STRING
DEFINE g_sql                 STRING
DEFINE g_rec_b               LIKE type_t.num10 #5           
DEFINE l_ac                  LIKE type_t.num10 #5    

DEFINE g_detail_cnt          LIKE type_t.num10 #5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10 #5              #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10 #5              #單身2目前所在筆數
                                                        
DEFINE g_current_row         LIKE type_t.num10 #5              #Browser所在筆數
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義模組變數(Module Variable)
   DEFINE g_inbldocno       LIKE inbl_t.inbldocno
   DEFINE g_acc             LIKE gzcb_t.gzcb007
   DEFINE l_inbk005         LIKE inbk_t.inbk005
   DEFINE p_cmd             LIKE type_t.chr5
   DEFINE l_result          LIKE type_t.chr5
   DEFINE l_sql             STRING
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define

   #DEFINE l_inbl          RECORD LIKE inbl_t.*  #161124-00048#5  2016/12/09 By 08734 mark
   #161124-00048#5  2016/12/09 By 08734 add(S)
   DEFINE l_inbl RECORD  #庫存有效日期變更明細檔
       inblent LIKE inbl_t.inblent, #企业编号
       inblsite LIKE inbl_t.inblsite, #营运据点
       inbldocno LIKE inbl_t.inbldocno, #单据编号
       inblseq LIKE inbl_t.inblseq, #项次
       inbl001 LIKE inbl_t.inbl001, #料件编号
       inbl002 LIKE inbl_t.inbl002, #产品特征
       inbl003 LIKE inbl_t.inbl003, #批号
       inbl004 LIKE inbl_t.inbl004, #制造批号
       inbl005 LIKE inbl_t.inbl005, #制造序号
       inbl006 LIKE inbl_t.inbl006, #原始有效日期
       inbl007 LIKE inbl_t.inbl007, #变更后有效日期
       inbl008 LIKE inbl_t.inbl008, #原因码
       inbl009 LIKE inbl_t.inbl009 #备注
END RECORD
#161124-00048#5  2016/12/09 By 08734 add(E)
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_tmp           LIKE type_t.chr5
#end add-point
 
{</section>}
 
{<section id="aint180_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aint180_01.other_dialog" >}

 
{</section>}
 
{<section id="aint180_01.other_function" readonly="Y" >}

PUBLIC FUNCTION aint180_01(--)
   #add-point:input段變數傳入
   p_inbldocno
   #end add-point
   )
   DEFINE p_inbldocno     LIKE inbl_t.inbldocno
   #end add-point
   #add-point:input段define
   IF cl_null(p_inbldocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   LET g_inbldocno = p_inbldocno
   LET g_master.l_type = '1'
   #end add-point

   #畫面開啟 (identifier)
   OPEN WINDOW w_aint180_01 WITH FORM cl_ap_formpath("ain","aint180_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   CALL aint180_01_init()
   
   CALL aint180_01_ui_dialog()
      
   
   
   #畫面關閉
   CLOSE WINDOW w_aint180_01

   #add-point:input段after input

   #end add-point

END FUNCTION

PRIVATE FUNCTION aint180_01_init()
   LET g_acc = ''
   #抓取[T:系統分類值檔].[C:系統分類碼]=24且[T:系統分類值檔].[C:系統分類碼]=g_prog 的[T:系統分類值檔].[C:參考欄位>
   #SELECT gzcb004 INTO g_acc FROM gzcb_t WHERE gzcb001 = '24' AND gzcb002 = 'aint180'                            #160705-00042#7 160715 by sakura mark
   SELECT gzcb004 INTO g_acc FROM gzcb_t,gzzz_t WHERE gzcb001 = '24' AND gzcb002 = gzzz006 AND gzzz001 = g_prog   #160705-00042#7 160715 by sakura add 
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'

   #輸入前處理
   #add-point:單身前置處理
   CLEAR FORM
   CALL g_inbl_d.clear()
   LET g_master.l_month = NULL
   LET g_master.l_day = NULL
   LET g_master.l_upddate = NULL
   CALL cl_set_comp_entry("l_ok",FALSE)
   CALL cl_set_comp_entry("l_all",FALSE)
   CALL cl_set_comp_entry("l_none",FALSE)
   #end add-point
END FUNCTION

PRIVATE FUNCTION aint180_01_ui_dialog()
   WHILE TRUE   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_master.l_type,g_master.l_upddate,g_master.l_month,g_master.l_day 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
         CALL cl_set_comp_entry("l_upddate",TRUE)
         CALL cl_set_comp_entry("l_month,l_day",FALSE)
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD l_type
            #add-point:BEFORE FIELD l_type

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD l_type
            
            #add-point:AFTER FIELD l_type
            CASE g_master.l_type 
               WHEN '1'
                  CALL cl_set_comp_entry("l_upddate",TRUE)
                  CALL cl_set_comp_entry("l_month,l_day",FALSE)
                  INITIALIZE g_master.l_month TO NULL
                  INITIALIZE g_master.l_day TO NULL
                  DISPLAY g_master.l_month TO l_month
                  DISPLAY g_master.l_day TO l_day
               WHEN '2'
                  CALL cl_set_comp_entry("l_upddate",FALSE)
                  CALL cl_set_comp_entry("l_month,l_day",TRUE)
                  INITIALIZE g_master.l_upddate TO NULL
                  DISPLAY g_master.l_upddate TO l_upddate
            END CASE
            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE l_type
            #add-point:ON CHANGE l_type
            CASE g_master.l_type 
               WHEN '1'
                  CALL cl_set_comp_entry("l_upddate",TRUE)
                  CALL cl_set_comp_entry("l_month,l_day",FALSE)
                  INITIALIZE g_master.l_month TO NULL
                  INITIALIZE g_master.l_day TO NULL
                  DISPLAY g_master.l_month TO l_month
                  DISPLAY g_master.l_day TO l_day
               WHEN '2'
                  CALL cl_set_comp_entry("l_upddate",FALSE)
                  CALL cl_set_comp_entry("l_month,l_day",TRUE)
                  INITIALIZE g_master.l_upddate TO NULL
                  DISPLAY g_master.l_upddate TO l_upddate
            END CASE
            #END add-point 
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD l_upddate
            #add-point:BEFORE FIELD l_upddate
            CASE g_master.l_type 
               WHEN '1'
                  CALL cl_set_comp_entry("l_upddate",TRUE)
                  CALL cl_set_comp_entry("l_month,l_day",FALSE)
                  INITIALIZE g_master.l_month TO NULL
                  INITIALIZE g_master.l_day TO NULL
                  DISPLAY g_master.l_month TO l_month
                  DISPLAY g_master.l_day TO l_day
               WHEN '2'
                  CALL cl_set_comp_entry("l_upddate",FALSE)
                  CALL cl_set_comp_entry("l_month,l_day",TRUE)
                  INITIALIZE g_master.l_upddate TO NULL
                  DISPLAY g_master.l_upddate TO l_upddate
            END CASE
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD l_upddate
            
            #add-point:AFTER FIELD l_upddate

            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE l_upddate
            #add-point:ON CHANGE l_upddate

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD l_month
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_month,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_month
            END IF 
 
 
            #add-point:AFTER FIELD l_month
            IF NOT cl_null(g_master.l_month) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD l_month
            #add-point:BEFORE FIELD l_month
            CASE g_master.l_type 
               WHEN '1'
                  CALL cl_set_comp_entry("l_upddate",TRUE)
                  CALL cl_set_comp_entry("l_month,l_day",FALSE)
                  INITIALIZE g_master.l_month TO NULL
                  INITIALIZE g_master.l_day TO NULL
                  DISPLAY g_master.l_month TO l_month
                  DISPLAY g_master.l_day TO l_day
               WHEN '2'
                  CALL cl_set_comp_entry("l_upddate",FALSE)
                  CALL cl_set_comp_entry("l_month,l_day",TRUE)
                  INITIALIZE g_master.l_upddate TO NULL
                  DISPLAY g_master.l_upddate TO l_upddate
            END CASE
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE l_month
            #add-point:ON CHANGE l_month

            #END add-point 
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD l_day
            #應用 a15 樣板自動產生(Version:2)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_day,"0","1","","","azz-00079",1) THEN
               NEXT FIELD l_day
            END IF 
 
 
            #add-point:AFTER FIELD l_day
            IF NOT cl_null(g_master.l_day) THEN 
            END IF 


            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD l_day
            #add-point:BEFORE FIELD l_day
            CASE g_master.l_type 
               WHEN '1'
                  CALL cl_set_comp_entry("l_upddate",TRUE)
                  CALL cl_set_comp_entry("l_month,l_day",FALSE)
                  INITIALIZE g_master.l_month TO NULL
                  INITIALIZE g_master.l_day TO NULL
                  DISPLAY g_master.l_month TO l_month
                  DISPLAY g_master.l_day TO l_day
               WHEN '2'
                  CALL cl_set_comp_entry("l_upddate",FALSE)
                  CALL cl_set_comp_entry("l_month,l_day",TRUE)
                  INITIALIZE g_master.l_upddate TO NULL
                  DISPLAY g_master.l_upddate TO l_upddate
            END CASE
            #END add-point
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE l_day
            #add-point:ON CHANGE l_day

            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.l_type
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD l_type
            #add-point:ON ACTION controlp INFIELD l_type

            #END add-point
 
         #Ctrlp:input.c.l_upddate
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD l_upddate
            #add-point:ON ACTION controlp INFIELD l_upddate

            #END add-point
 
         #Ctrlp:input.c.l_month
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD l_month
            #add-point:ON ACTION controlp INFIELD l_month

            #END add-point
 
         #Ctrlp:input.c.l_day
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD l_day
            #add-point:ON ACTION controlp INFIELD l_day

            #END add-point
 
 #欄位開窗
            
         AFTER INPUT
            CASE g_master.l_type
               WHEN '1'
                  IF cl_null(g_master.l_upddate) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00515'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD l_upddate
                  END IF
               WHEN '2'
                  IF cl_null(g_master.l_month) AND cl_null(g_master.l_day) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00516'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD l_month
                  END IF
            END CASE
            
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
      END INPUT

      

      #QBE開始
      CONSTRUCT BY NAME g_wc ON inag001,inag002,imaa009,inad011,inag004,inag005,inag006,imaf052
      
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
            
         ON ACTION controlp INFIELD imaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009      #顯示到畫面上
            NEXT FIELD imaa009                         #返回原欄位
            
#         ON ACTION controlp INFIELD inad011          
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE
#            CALL q_inag003()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO inad011      #顯示到畫面上
#            NEXT FIELD inad011                         #返回原欄位
            
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
            
         ON ACTION controlp INFIELD imaf052
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf052      #顯示到畫面上
            NEXT FIELD imaf052                         #返回原欄位
            
         AFTER CONSTRUCT
            LET l_flag1 = 'N'
            
      END CONSTRUCT
      
      AFTER DIALOG
            CASE g_master.l_type
               WHEN '1'
                  IF cl_null(g_master.l_upddate) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00515'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD l_upddate
                  END IF
               WHEN '2'
                  IF cl_null(g_master.l_month) AND cl_null(g_master.l_day) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ain-00516'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD l_month
                  END IF
            END CASE
            
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            CALL aint180_01_b_fill()
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

 
      BEFORE DIALOG
         CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)


         #公用action
         ON ACTION accept
            ACCEPT DIALOG
   
         ON ACTION cancel
            #add-point:cancel
   
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
   
      #單身內容是可以修改的
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
        INPUT ARRAY g_inbl_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         BEFORE INPUT
            LET l_flag1 = 'P'
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.idx
         
#         AFTER INPUT
#            IF INT_FLAG THEN
#               EXIT DIALOG
#            END IF  
#         END INPUT          
         #應用 a01 樣板自動產生(Version:1)


         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inbl007
            #add-point:BEFORE FIELD inbl007

            #END add-point

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inbl007

            #add-point:AFTER FIELD inbl007

            #END add-point


         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE inbl007
            #add-point:ON CHANGE inbl007

            #END add-point

         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD inbl008

            #add-point:AFTER FIELD inbl008
            IF NOT cl_null(g_inbl_d[l_ac].inbl008) THEN
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_inbl_d[l_ac].inbl008
               CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='"||g_acc||"' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_inbl_d[l_ac].inbl008_desc = '', g_rtn_fields[1] , ''
               DISPLAY BY NAME g_inbl_d[l_ac].inbl008_desc
            END IF

            #END add-point


         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD inbl008
            #add-point:BEFORE FIELD inbl008

            #END add-point

         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE inbl008
            #add-point:ON CHANGE inbl008

            #END add-point


                  #Ctrlp:input.c.page1.inbl001


         #Ctrlp:input.c.page1.inbl006


         #Ctrlp:input.c.page1.inbl007
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD inbl007
            #add-point:ON ACTION controlp INFIELD inbl007

            #END add-point

         #Ctrlp:input.c.page1.inbl008
#         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD inbl008
            #add-point:ON ACTION controlp INFIELD inbl008
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_inbl_d[l_ac].inbl008             #給予default值
            
            #給予arg
            LET g_qryparam.arg1 = g_acc #s

            CALL q_oocq002()                                #呼叫開窗

            LET g_inbl_d[l_ac].inbl008 = g_qryparam.return1              
            
            DISPLAY g_inbl_d[l_ac].inbl008 TO inbl008              #
            
            NEXT FIELD inbl008                          #返回原欄位
            #END add-point



         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...)

         #end add-point

         AFTER INPUT
            #add-point:單身輸入後處理
            
            #end add-point

      END INPUT
      
         ON ACTION l_all
            FOR l_i = 1 TO g_rec_b
               LET g_inbl_d[l_i].l_choice = 'Y'
            END FOR

         ON ACTION l_none
            FOR l_i = 1 TO g_rec_b
               LET g_inbl_d[l_i].l_choice = 'N'
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
         EXIT WHILE
         RETURN 
      END IF
      #end add-point
      CALL cl_ask_confirm("afm-00010") RETURNING l_result
      IF l_result = '1' THEN
         FOR l_i = 1 TO g_rec_b
            IF g_inbl_d[l_i].l_choice = 'N' THEN
               CONTINUE FOR
            END IF
            INITIALIZE l_inbl.* TO NULL
            LET l_inbl.inblent = g_enterprise
            LET l_inbl.inblsite = g_site
            LET l_inbl.inbldocno = g_inbldocno
#           LET l_sql = "SELECT MAX(inblseq)+1 FROM inbl_t WHERE inblent=",g_enterprise ," AND inblsite='",g_site ,"' AND inbldocno = '", g_inbldocno ,"' "
#            PREPARE ins_inbl_pre FROM l_sql
#            EXECUTE ins_inbl_pre INTO l_tmp

            IF cl_null(g_inbl_d[l_i].inbl001) THEN
               CONTINUE FOR
            END IF
            SELECT MAX(inblseq)+1 INTO l_inbl.inblseq FROM inbl_t WHERE inblent=g_enterprise AND inblsite=g_site AND inbldocno = g_inbldocno
            IF cl_null(l_inbl.inblseq) THEN 
               LET l_inbl.inblseq = 1
            END IF
         
            LET l_inbl.inbl001 = g_inbl_d[l_i].inbl001
            LET l_inbl.inbl002 = g_inbl_d[l_i].inbl002
            LET l_inbl.inbl003 = g_inbl_d[l_i].inbl003
            LET l_inbl.inbl006 = g_inbl_d[l_i].inbl006
            LET l_inbl.inbl007 = g_inbl_d[l_i].inbl007
            LET l_inbl.inbl008 = g_inbl_d[l_i].inbl008
         
            CALL aint180_01_control_chk(l_inbl.inbl001,l_inbl.inbl002,l_inbl.inbl003) RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'ain-00508'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT FOR
            END IF
         
            #INSERT INTO inbl_t VALUES l_inbl.*  #161124-00048#5  2016/12/09 By 08734 mark
            INSERT INTO inbl_t(inblent,inblsite,inbldocno,inblseq,inbl001,inbl002,inbl003,inbl004,inbl005,inbl006,inbl007,inbl008,inbl009)  #161124-00048#5  2016/12/09 By 08734 add
               VALUES (l_inbl.inblent,l_inbl.inblsite,l_inbl.inbldocno,l_inbl.inblseq,l_inbl.inbl001,l_inbl.inbl002,l_inbl.inbl003,l_inbl.inbl004,l_inbl.inbl005,l_inbl.inbl006,l_inbl.inbl007,l_inbl.inbl008,l_inbl.inbl009)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ins inbl_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               EXIT WHILE
#              CLOSE WINDOW w_aint180_01
               RETURN
            END IF
         END FOR   
      END IF
      
      CALL cl_ask_confirm("lib-005") RETURNING l_result    
      IF NOT l_result THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF
   
#      CLEAR FORM
#      INITIALIZE g_master.* TO NULL
      CALL aint180_01_init()
   END WHILE
END FUNCTION
#更具查詢條件，顯示單身
PRIVATE FUNCTION aint180_01_b_fill()
   LET l_inbk005 = NULL
   SELECT inbk005 INTO l_inbk005 FROM inbk_t WHERE inbkdocno = g_inbldocno AND inbkent = g_enterprise AND inbksite = g_site
   LET g_sql = "SELECT DISTINCT 'N',inad001,'','',inad002,'',inad003,inad011,'','','',inadsite FROM inad_t  ",
            "LEFT OUTER JOIN inag_t ON inad001 = inag001 AND inad002 = inag002 AND inad003 = inag006 AND inadent = inagent AND inadsite = inagsite",
            " WHERE inadent=",g_enterprise," AND inadsite='",g_site,"' "
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   LET g_sql = g_sql," AND ",g_wc
   PREPARE aint180_01_pre FROM g_sql
   DECLARE aint180_01_cs CURSOR FOR aint180_01_pre
   CALL g_inbl_d.clear()
   LET l_ac = 1
   FOREACH aint180_01_cs INTO g_inbl_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF NOT aint180_01_control_chk(g_inbl_d[l_ac].inbl001,g_inbl_d[l_ac].inbl002,g_inbl_d[l_ac].inbl003) THEN
         INITIALIZE g_inbl_d[l_ac].* TO NULL
         CONTINUE FOREACH
      END IF
      CALL aint180_01_b_desc()
      IF NOT cl_null(l_inbk005) THEN
         LET g_inbl_d[l_ac].inbl008 = l_inbk005
      END IF
      CASE g_master.l_type
         WHEN '1'
            IF NOT cl_null(g_master.l_upddate) THEN
               LET g_inbl_d[l_ac].inbl007 = g_master.l_upddate
            END IF
         WHEN '2'
            IF NOT cl_null(g_inbl_d[l_ac].inbl006) AND (NOT cl_null(g_master.l_month) OR NOT cl_null(g_master.l_day)) THEN
               CALL s_date_get_date(g_inbl_d[l_ac].inbl006,g_master.l_month,g_master.l_day) RETURNING g_inbl_d[l_ac].inbl007 
            END IF
      END CASE
      DISPLAY g_inbl_d[l_ac].inbl007 TO inbl007
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_inbl_d.deleteElement(l_ac)
   LET g_rec_b = l_ac - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   FREE aint180_01_pre
   IF g_rec_b > 0 THEN
      CALL cl_set_comp_entry("l_all",TRUE)
      CALL cl_set_comp_entry("l_none",TRUE)
   END IF
END FUNCTION

################################################################################
#顯示ref
################################################################################
PRIVATE FUNCTION aint180_01_b_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_inbl_d[l_ac].inbl001
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_inbl_d[l_ac].inbl001_desc = '', g_rtn_fields[1] , ''
   LET g_inbl_d[l_ac].inbl001_desc_1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_inbl_d[l_ac].inbl001_desc,g_inbl_d[l_ac].inbl001_desc_1
   
   IF NOT cl_null(g_inbl_d[l_ac].inbl002) THEN
      CALL s_feature_description(g_inbl_d[l_ac].inbl001,g_inbl_d[l_ac].inbl002) RETURNING g_success,g_inbl_d[l_ac].l_inbl002_desc
      DISPLAY g_inbl_d[l_ac].inbl002 TO inbl002
   END IF
END FUNCTION

PRIVATE FUNCTION aint180_01_control_chk(p_inbl001,p_inbl002,p_inbl003)
   DEFINE p_inbl001   LIKE inbl_t.inbl001
   DEFINE p_inbl002   LIKE inbl_t.inbl002
   DEFINE p_inbl003   LIKE inbl_t.inbl003
   DEFINE l_sql       STRING
   DEFINE l_cnt       LIKE type_t.num5
   
   DEFINE r_success   LIKE type_t.num5
   
   SELECT COUNT(*) INTO l_cnt FROM inbl_t
    WHERE inbl001 = p_inbl001
      AND inbl002 = p_inbl002
      AND inbl003 = p_inbl003
      AND inbldocno = g_inbldocno
      AND inblent = g_enterprise
      AND inblsite = g_site
   
   LET r_success = TRUE  
   IF l_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   RETURN r_success
END FUNCTION

 
{</section>}
 

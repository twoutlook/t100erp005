#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi915_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2013-11-18 11:45:21), PR版次:0004(2015-04-13 10:07:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000114
#+ Filename...: azzi915_02
#+ Description: 查詢方案群組維護
#+ Creator....: 00413(2013-11-15 00:00:00)
#+ Modifier...: 00413 -SD/PR- 00413
 
{</section>}
 
{<section id="azzi915_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

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
 
{<section id="azzi915_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
PRIVATE type type_g_gzxol_m        RECORD
       gzxol001 LIKE gzxol_t.gzxol001,
   gzxol002 LIKE gzxol_t.gzxol002,
   gzxol003 LIKE gzxol_t.gzxol003,
   gzxol004 LIKE gzxol_t.gzxol004,
   gzxol005 LIKE gzxol_t.gzxol005
       END RECORD
DEFINE g_gzxol_m        type_g_gzxol_m

DEFINE g_gzxol001_t   LIKE gzxol_t.gzxol001    #Key值備份
DEFINE g_gzxol002_t      LIKE gzxol_t.gzxol002    #Key值備份

DEFINE g_gzxol003_t      LIKE gzxol_t.gzxol003    #Key值備份

DEFINE g_gzxol004_t      LIKE gzxol_t.gzxol004    #Key值備份

DEFINE g_master_multi_table_t    RECORD
      gzxol001 LIKE gzxol_t.gzxol001,
      gzxol002 LIKE gzxol_t.gzxol002,
      gzxol003 LIKE gzxol_t.gzxol003,
      gzxol005 LIKE gzxol_t.gzxol005
      END RECORD

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="azzi915_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="azzi915_02.other_dialog" >}

 
{</section>}
 
{<section id="azzi915_02.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 新增/修改查詢方案或群組
# Memo...........: 
# Usage..........: CALL azzi915_02(pc_gzxo001,pc_gzxo002,pc_gzxo003,"group")
# Input parameter: pc_gzxo001   查詢方案群組編號
# ...............: pc_gzxo002   作業編號
# ...............: pc_gzxo003   員工編號
# ...............: ps_level     group/plan
# ...............: pi_groupid   查詢方案群組編號
# Return code....: li_result    TRUE/FALSE 新增/修改成功與否
# Date & Author..: 2013/11/15 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi915_02(pc_gzxo001,pc_gzxo002,pc_gzxo003,ps_level,pi_groupid)
   #add-point:input段變數傳入
   {<point name="input.get_var"/>}
   DEFINE pc_gzxo001      LIKE gzxo_t.gzxo001
   DEFINE pc_gzxo002      LIKE gzxo_t.gzxo002
   DEFINE pc_gzxo003      LIKE gzxo_t.gzxo003
   DEFINE ps_level        STRING
   DEFINE pi_groupid      LIKE type_t.num10       #ps_level=group時,不理會此值
   DEFINE li_result       BOOLEAN
   #end add-point
   {<Local define>}
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE ls_master       STRING
   DEFINE ls_master_cmt   STRING
   DEFINE lwin_curr       ui.Window
   DEFINE lfrm_curr       ui.Form
   DEFINE ls_table        STRING
   {</Local define>}
   #add-point:input段define
   {<point name="input.define"/>}
   #end add-point

   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi915_02 WITH FORM cl_ap_formpath("azz","azzi915_02")

   LET g_qryparam.state = "i"
   LET p_cmd = 'a'

   #輸入前處理
   #add-point:單頭前置處理
   {<point name="input.pre_input"/>}
   IF cl_null(pc_gzxo001) THEN
      LET p_cmd = "a"
   ELSE
      LET p_cmd = "u"
   END IF
   LET g_gzxol_m.gzxol001 = pc_gzxo001
   LET g_gzxol_m.gzxol002 = pc_gzxo002
   LET g_gzxol_m.gzxol003 = pc_gzxo003

   #修改畫面提示
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   IF ps_level = "plan" THEN
      CALL s_azzi902_get_gzzd("azzi915_02", "master_plan") RETURNING ls_master, ls_master_cmt
      CALL lfrm_curr.setElementText("master", ls_master)
   END IF

   #gzxo001傳入NULL為新增, 在n_gzxol001前insert到gzxo_t, 最後若是取消再刪掉兩者資料
   #gzxo001若有值, 則先找出多語言顯示在畫面上
   IF p_cmd = "u" THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_gzxol_m.gzxol001
      LET g_ref_fields[2] = g_gzxol_m.gzxol002
      LET g_ref_fields[3] = g_gzxol_m.gzxol003
      CASE ps_level
         WHEN "group"
            CALL ap_ref_array2(g_ref_fields," SELECT gzxol005 FROM gzxol_t WHERE gzxol001 = ? AND gzxol002 = ? AND gzxol003 = ? AND gzxolent = '"||g_enterprise||"' AND  gzxol004 = '"||g_lang CLIPPED||"'","") RETURNING g_rtn_fields
         WHEN "plan"
            CALL ap_ref_array2(g_ref_fields," SELECT gzxml005 FROM gzxml_t WHERE gzxml001 = ? AND gzxml002 = ? AND gzxml003 = ? AND gzxmlent = '"||g_enterprise||"' AND  gzxml004 = '"||g_lang CLIPPED||"'","") RETURNING g_rtn_fields
      END CASE
      LET g_gzxol_m.gzxol005 = g_rtn_fields[1]
      DISPLAY BY NAME g_gzxol_m.gzxol005
   ELSE
      LET g_gzxol_m.gzxol005 = ""
   END IF
   LET li_result = TRUE
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_gzxol_m.gzxol005 ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION
         #add-point:單頭前置處理
         {<point name="input.action"/>}
         #end add-point
         ON ACTION update_item
            LET g_action_choice="update_item"
            IF cl_auth_chk_act("update_item") THEN 
               #add-point:ON ACTION update_item
               IF NOT cl_null(g_gzxol_m.gzxol001) THEN
                  CASE ps_level
                     WHEN "group"
                        CALL n_gzxol(g_gzxol_m.gzxol001, g_gzxol_m.gzxol002, g_gzxol_m.gzxol003)
                     WHEN "plan"
                        CALL n_gzxml(g_gzxol_m.gzxol001, g_gzxol_m.gzxol002, g_gzxol_m.gzxol003)
                  END CASE
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_gzxol_m.gzxol001
                  LET g_ref_fields[2] = g_gzxol_m.gzxol002
                  LET g_ref_fields[3] = g_gzxol_m.gzxol003
                  CASE ps_level
                     WHEN "group"
                        CALL ap_ref_array2(g_ref_fields," SELECT gzxol005 FROM gzxol_t WHERE gzxol001 = ? AND gzxol002 = ? AND gzxol003 = ? AND gzxolent = '"||g_enterprise||"' AND  gzxol004 = '"||g_lang CLIPPED||"'","") RETURNING g_rtn_fields
                     WHEN "plan"
                        CALL ap_ref_array2(g_ref_fields," SELECT gzxml005 FROM gzxml_t WHERE gzxml001 = ? AND gzxml002 = ? AND gzxml003 = ? AND gzxmlent = '"||g_enterprise||"' AND  gzxml004 = '"||g_lang CLIPPED||"'","") RETURNING g_rtn_fields
                  END CASE
                  LET g_gzxol_m.gzxol005 = g_rtn_fields[1]
                  DISPLAY BY NAME g_gzxol_m.gzxol005
               END IF
               #END add-point
            END IF
         #自訂ACTION(master_input)


         BEFORE INPUT
            LET g_master_multi_table_t.gzxol001 = g_gzxol_m.gzxol001
            LET g_master_multi_table_t.gzxol002 = g_gzxol_m.gzxol002
            LET g_master_multi_table_t.gzxol003 = g_gzxol_m.gzxol003
            LET g_master_multi_table_t.gzxol005 = g_gzxol_m.gzxol005

            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            #add-point:單頭輸入前處理
            {<point name="input.before_input"/>}
            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<gzxol001>>----
         #此段落由子樣板a01產生
         #----<<gzxol005>>----
         #此段落由子樣板a01產生
         BEFORE FIELD gzxol005
            #add-point:BEFORE FIELD gzxol005
            {<point name="input.b.gzxol005" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD gzxol005

            #add-point:AFTER FIELD gzxol005
            {<point name="input.a.gzxol005" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE gzxol005
            #add-point:ON CHANGE gzxol005
            {<point name="input.g.gzxol005" />}
            #END add-point

         AFTER INPUT
            #add-point:單頭輸入後處理
            {<point name="input.after_input"/>}
            IF INT_FLAG THEN
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF
            IF p_cmd <> "u" THEN
               LET li_result = TRUE
               CALL azzi915_02_gzxo_insert(ps_level, pi_groupid) RETURNING g_gzxol_m.gzxol001
               IF cl_null(g_gzxol_m.gzxol001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  g_errno
                  LET g_errparam.extend = "g_gzxol_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET li_result = FALSE
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               ELSE
                  INITIALIZE l_var_keys TO NULL
                  INITIALIZE l_field_keys TO NULL
                  INITIALIZE l_vars TO NULL
                  INITIALIZE l_fields TO NULL
                  IF g_gzxol_m.gzxol001 = g_master_multi_table_t.gzxol001 AND
                     g_gzxol_m.gzxol002 = g_master_multi_table_t.gzxol002 AND
                     g_gzxol_m.gzxol003 = g_master_multi_table_t.gzxol003 AND
                     g_gzxol_m.gzxol005 = g_master_multi_table_t.gzxol005 THEN
                  ELSE
                     CASE ps_level
                        WHEN "group" LET ls_table = "gzxol"
                        WHEN "plan"  LET ls_table = "gzxml"
                     END CASE
                     LET l_var_keys[01] = g_gzxol_m.gzxol001
                     LET l_field_keys[01] = ls_table, '001'
                     LET l_var_keys_bak[01] = g_master_multi_table_t.gzxol001
                     LET l_var_keys[02] = g_gzxol_m.gzxol002
                     LET l_field_keys[02] = ls_table, '002'
                     LET l_var_keys_bak[02] = g_master_multi_table_t.gzxol002
                     LET l_var_keys[03] = g_gzxol_m.gzxol003
                     LET l_field_keys[03] = ls_table, '003'
                     LET l_var_keys_bak[03] = g_master_multi_table_t.gzxol003
                     LET l_var_keys[04] = g_dlang
                     LET l_field_keys[04] = ls_table, '004'
                     LET l_var_keys_bak[04] = g_dlang
                     LET l_var_keys[05] = g_enterprise
                     LET l_field_keys[05] = ls_table, 'ent'
                     LET l_var_keys_bak[05] = g_enterprise
                     LET l_vars[01] = g_gzxol_m.gzxol005
                     LET l_fields[01] = ls_table, '005'
                     CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,ls_table||'_t')
                  END IF
               END IF
               CALL s_transaction_end('Y','0')
               LET p_cmd = 'u'
            ELSE
               INITIALIZE l_var_keys TO NULL
               INITIALIZE l_field_keys TO NULL
               INITIALIZE l_vars TO NULL
               INITIALIZE l_fields TO NULL
               IF g_gzxol_m.gzxol001 = g_master_multi_table_t.gzxol001 AND
                  g_gzxol_m.gzxol002 = g_master_multi_table_t.gzxol002 AND
                  g_gzxol_m.gzxol003 = g_master_multi_table_t.gzxol003 AND
                  g_gzxol_m.gzxol005 = g_master_multi_table_t.gzxol005 THEN
               ELSE
                  CASE ps_level
                     WHEN "group" LET ls_table = "gzxol"
                     WHEN "plan"  LET ls_table = "gzxml"
                  END CASE
                  LET l_var_keys[01] = g_gzxol_m.gzxol001
                  LET l_field_keys[01] = ls_table, '001'
                  LET l_var_keys_bak[01] = g_master_multi_table_t.gzxol001
                  LET l_var_keys[02] = g_gzxol_m.gzxol002
                  LET l_field_keys[02] = ls_table, '002'
                  LET l_var_keys_bak[02] = g_master_multi_table_t.gzxol002
                  LET l_var_keys[03] = g_gzxol_m.gzxol003
                  LET l_field_keys[03] = ls_table, '003'
                  LET l_var_keys_bak[03] = g_master_multi_table_t.gzxol003
                  LET l_var_keys[04] = g_dlang
                  LET l_field_keys[04] = ls_table, '004'
                  LET l_var_keys_bak[04] = g_dlang
                  LET l_var_keys[05] = g_enterprise
                  LET l_field_keys[05] = ls_table, 'ent'
                  LET l_var_keys_bak[05] = g_enterprise
                  LET l_vars[01] = g_gzxol_m.gzxol005
                  LET l_fields[01] = ls_table, '005'
                  CALL cl_multitable(l_var_keys,l_field_keys,l_vars,l_fields,l_var_keys_bak,ls_table||'_t')
               END IF
               CALL s_transaction_end('Y','0')
            END IF
            #end add-point

      END INPUT

      #add-point:自定義input
      {<point name="input.more_input"/>}
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

   #add-point:畫面關閉前
   {<point name="input.before_close"/>}
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET li_result = FALSE
   END IF
   #end add-point

   #畫面關閉
   CLOSE WINDOW w_azzi915_02

   #add-point:input段after input
   {<point name="input.post_input"/>}
   RETURN li_result
   #end add-point

END FUNCTION
################################################################################
# Descriptions...: 新增查詢方案或群組
# Memo...........: 
# Usage..........: CALL azzi915_02_gzxo_insert(group, 0)
# Input parameter: ps_level     group/plan
# ...............: pi_groupid   方案須新增進某群組
# Return code....: gzxo001      查詢方案(群組)編號
# Date & Author..: 2013/11/18 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi915_02_gzxo_insert(ps_level,pi_groupid)
   DEFINE   ps_level     STRING
   DEFINE   pi_groupid   LIKE gzxo_t.gzxo001
   DEFINE   lc_gzxo001   LIKE gzxo_t.gzxo001
   DEFINE   lc_gzxo004   LIKE gzxo_t.gzxo004
   DEFINE   lr_gzxo      RECORD LIKE gzxo_t.*
   DEFINE   lc_gzxm001   LIKE gzxm_t.gzxm001
   DEFINE   lc_gzxm009   LIKE gzxm_t.gzxm009
   DEFINE   lr_gzxm      RECORD LIKE gzxm_t.*

   IF ps_level = "plan" AND g_gzxol_m.gzxol003 = "DEFAULT" AND
      (cl_null(pi_groupid) OR pi_groupid <= 0) THEN
      RETURN ""
   END IF

   CASE ps_level
      WHEN "group"
         # 取編號
         SELECT MAX(gzxo001) + 1 INTO lc_gzxo001 FROM gzxo_t
          WHERE gzxoent = g_enterprise AND gzxo002 = g_gzxol_m.gzxol002 AND gzxo003 = g_gzxol_m.gzxol003
         IF cl_null(lc_gzxo001) THEN
            LET lc_gzxo001 = 1
            LET lc_gzxo004 = 1
         ELSE
            # 取順序
            SELECT MAX(gzxo004) + 1 INTO lc_gzxo004 FROM gzxo_t
             WHERE gzxoent = g_enterprise AND gzxo002 = g_gzxol_m.gzxol002 AND gzxo003 = g_gzxol_m.gzxol003
         END IF

         LET lr_gzxo.gzxo001 = lc_gzxo001
         LET lr_gzxo.gzxo002 = g_gzxol_m.gzxol002
         LET lr_gzxo.gzxo003 = g_gzxol_m.gzxol003
         LET lr_gzxo.gzxo004 = lc_gzxo004
         LET lr_gzxo.gzxoent = g_enterprise
         LET lr_gzxo.gzxostus = "Y"
         LET lr_gzxo.gzxoownid = g_user
         LET lr_gzxo.gzxoowndp = g_dept
         LET lr_gzxo.gzxocrtid = g_user
         LET lr_gzxo.gzxocrtdp = g_dept
         LET lr_gzxo.gzxocrtdt = cl_get_current()

         INSERT INTO gzxo_t(gzxostus,gzxoent,gzxo001,gzxo002,gzxo003,gzxo004,gzxoownid,gzxoowndp,gzxocrtid,gzxocrtdp,gzxocrtdt)
                     VALUES(lr_gzxo.gzxostus,lr_gzxo.gzxoent,lr_gzxo.gzxo001,lr_gzxo.gzxo002,lr_gzxo.gzxo003,lr_gzxo.gzxo004,lr_gzxo.gzxoownid,lr_gzxo.gzxoowndp,lr_gzxo.gzxocrtid,lr_gzxo.gzxocrtdp,lr_gzxo.gzxocrtdt)
         IF SQLCA.sqlcode THEN
            LET g_errno = SQLCA.sqlcode
            RETURN ""
         END IF
      WHEN "plan"
         # 取編號
         SELECT MAX(gzxm001) + 1 INTO lc_gzxm001 FROM gzxm_t
          WHERE gzxment = g_enterprise AND gzxm002 = g_gzxol_m.gzxol002 AND gzxm003 = g_gzxol_m.gzxol003
         IF cl_null(lc_gzxm001) THEN
            LET lc_gzxm001 = 1
         END IF
         # 取順序
         SELECT MAX(gzxm009) + 1 INTO lc_gzxm009 FROM gzxm_t
          WHERE gzxment = g_enterprise AND gzxm002 = g_gzxol_m.gzxol002 AND gzxm003 = g_gzxol_m.gzxol003 AND gzxm008 = pi_groupid
         IF cl_null(lc_gzxm009) THEN
            LET lc_gzxm009 = 1
         END IF

         LET lr_gzxm.gzxm001 = lc_gzxm001
         LET lr_gzxo.gzxo001 = lc_gzxm001
         LET lr_gzxm.gzxm002 = g_gzxol_m.gzxol002
         LET lr_gzxm.gzxm003 = g_gzxol_m.gzxol003
         LET lr_gzxm.gzxm004 = "N"
         LET lr_gzxm.gzxm005 = "N"
         LET lr_gzxm.gzxm008 = pi_groupid
         LET lr_gzxm.gzxm009 = lc_gzxm009
         LET lr_gzxm.gzxm010 = "N"
         LET lr_gzxm.gzxment = g_enterprise
         LET lr_gzxm.gzxmstus = "Y"
         LET lr_gzxm.gzxmownid = g_user
         LET lr_gzxm.gzxmowndp = g_dept
         LET lr_gzxm.gzxmcrtid = g_user
         LET lr_gzxm.gzxmcrtdp = g_dept
         LET lr_gzxm.gzxmcrtdt = cl_get_current()

         INSERT INTO gzxm_t(gzxmstus,gzxment,gzxm001,gzxm002,gzxm003,gzxm004,gzxm005,gzxm008,gzxm009,gzxm010,gzxmownid,gzxmowndp,gzxmcrtid,gzxmcrtdp,gzxmcrtdt)
                     VALUES(lr_gzxm.gzxmstus,lr_gzxm.gzxment,lr_gzxm.gzxm001,lr_gzxm.gzxm002,lr_gzxm.gzxm003,lr_gzxm.gzxm004,lr_gzxm.gzxm005,lr_gzxm.gzxm008,lr_gzxm.gzxm009,lr_gzxm.gzxm010,lr_gzxm.gzxmownid,lr_gzxm.gzxmowndp,lr_gzxm.gzxmcrtid,lr_gzxm.gzxmcrtdp,lr_gzxm.gzxmcrtdt)
         IF SQLCA.sqlcode THEN
            LET g_errno = SQLCA.sqlcode
            RETURN ""
         END IF
   END CASE

   RETURN lr_gzxo.gzxo001
END FUNCTION

 
{</section>}
 

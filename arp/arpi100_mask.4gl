
#應用 a64 樣板自動產生(Version:3)
#+ 資料遮罩
PRIVATE FUNCTION arpi100_browser_mask()
   #add-point:mask段define
   {<point name="browser_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="browser_mask.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   #進行遮罩處理
   #CALL cl_mask_trans_method('',) 
   #RETURNING 
   

   
END FUNCTION


#應用 a64 樣板自動產生(Version:3)
#+ 資料遮罩
PRIVATE FUNCTION arpi100_gzza_t_mask()
   #add-point:mask段define
   {<point name="gzza_t_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzza_t_mask.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   #進行遮罩處理
   #CALL cl_mask_trans_method('',) 
   #RETURNING 
   

   
END FUNCTION


#應用 a65 樣板自動產生(Version:3)
#+ 資料遮罩還原(FOR UPDATE)
PRIVATE FUNCTION arpi100_gzza_t_mask_restore(ps_type)
   #add-point:mask_restore段define
   {<point name="gzza_t_mask_restore.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   DEFINE ps_type  LIKE type_t.chr50
   DEFINE li_idx   LIKE type_t.num10
   #add-point:mask_restore段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzza_t_mask_restore.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   ##還原成遮罩前
   #IF ps_type = 'restore_mask_o' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
   #還原成遮罩後
   #IF ps_type = 'restore_mask_n' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
END FUNCTION


#應用 a64 樣板自動產生(Version:3)
#+ 資料遮罩
PRIVATE FUNCTION arpi100_gzzc_t_mask()
   #add-point:mask段define
   {<point name="gzzc_t_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzzc_t_mask.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   #進行遮罩處理
   #CALL cl_mask_trans_method('',) 
   #RETURNING 
   

   
END FUNCTION


#應用 a65 樣板自動產生(Version:3)
#+ 資料遮罩還原(FOR UPDATE)
PRIVATE FUNCTION arpi100_gzzc_t_mask_restore(ps_type)
   #add-point:mask_restore段define
   {<point name="gzzc_t_mask_restore.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   DEFINE ps_type  LIKE type_t.chr50
   DEFINE li_idx   LIKE type_t.num10
   #add-point:mask_restore段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzzc_t_mask_restore.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   ##還原成遮罩前
   #IF ps_type = 'restore_mask_o' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
   #還原成遮罩後
   #IF ps_type = 'restore_mask_n' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
END FUNCTION


#應用 a64 樣板自動產生(Version:3)
#+ 資料遮罩
PRIVATE FUNCTION arpi100_gzzk_t_mask()
   #add-point:mask段define
   {<point name="gzzk_t_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzzk_t_mask.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   #進行遮罩處理
   #CALL cl_mask_trans_method('',) 
   #RETURNING 
   

   
END FUNCTION


#應用 a65 樣板自動產生(Version:3)
#+ 資料遮罩還原(FOR UPDATE)
PRIVATE FUNCTION arpi100_gzzk_t_mask_restore(ps_type)
   #add-point:mask_restore段define
   {<point name="gzzk_t_mask_restore.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   DEFINE ps_type  LIKE type_t.chr50
   DEFINE li_idx   LIKE type_t.num10
   #add-point:mask_restore段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzzk_t_mask_restore.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   ##還原成遮罩前
   #IF ps_type = 'restore_mask_o' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
   #還原成遮罩後
   #IF ps_type = 'restore_mask_n' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
END FUNCTION


#應用 a64 樣板自動產生(Version:3)
#+ 資料遮罩
PRIVATE FUNCTION arpi100_gzdf_t_mask()
   #add-point:mask段define
   {<point name="gzdf_t_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzdf_t_mask.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   #進行遮罩處理
   #CALL cl_mask_trans_method('',) 
   #RETURNING 
   

   
END FUNCTION


#應用 a65 樣板自動產生(Version:3)
#+ 資料遮罩還原(FOR UPDATE)
PRIVATE FUNCTION arpi100_gzdf_t_mask_restore(ps_type)
   #add-point:mask_restore段define
   {<point name="gzdf_t_mask_restore.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   DEFINE ps_type  LIKE type_t.chr50
   DEFINE li_idx   LIKE type_t.num10
   #add-point:mask_restore段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   {<point name="gzdf_t_mask_restore.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   ##還原成遮罩前
   #IF ps_type = 'restore_mask_o' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
   #還原成遮罩後
   #IF ps_type = 'restore_mask_n' THEN
   #   FOR li_idx = 1 TO g_priv_col.getLength()
   #      IF g_priv_col[li_idx].colid = '' THEN
   #         LET  = 
   #      END IF

   #   END FOR
   #END IF
    
END FUNCTION



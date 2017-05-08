
#應用 a64 樣板自動產生(Version:4)
#+ 資料遮罩
PRIVATE FUNCTION arpi800_browser_mask()
   #add-point:mask段define name="browser_mask.define_customerization"
   {<point name="browser_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_mask.define"
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



#應用 a64 樣板自動產生(Version:4)
#+ 資料遮罩
PRIVATE FUNCTION arpi800_rpxa_t_mask()
   #add-point:mask段define name="rpxa_t_mask.define_customerization"
   {<point name="rpxa_t_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rpxa_t_mask.define"
   {<point name="rpxa_t_mask.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   #進行遮罩處理
   #CALL cl_mask_trans_method('',) 
   #RETURNING 
   

   
END FUNCTION



#應用 a65 樣板自動產生(Version:4)
#+ 資料遮罩還原(FOR UPDATE)
PRIVATE FUNCTION arpi800_rpxa_t_mask_restore(ps_type)
   #add-point:mask_restore段define name="rpxa_t_mask_restore.define_customerization"
   {<point name="rpxa_t_mask_restore.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   DEFINE ps_type  LIKE type_t.chr50
   DEFINE li_idx   LIKE type_t.num10
   #add-point:mask_restore段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rpxa_t_mask_restore.define"
   {<point name="rpxa_t_mask_restore.define"/>}
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



#應用 a64 樣板自動產生(Version:4)
#+ 資料遮罩
PRIVATE FUNCTION arpi800_rpxb_t_mask()
   #add-point:mask段define name="rpxb_t_mask.define_customerization"
   {<point name="rpxb_t_mask.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   #add-point:mask段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rpxb_t_mask.define"
   {<point name="rpxb_t_mask.define"/>}
   #end add-point   
   
   #先判斷是否有遮罩, 若無則不做處理
   IF g_priv_col.getLength() = 0 THEN
      RETURN
   END IF
   
   #進行遮罩處理
   #CALL cl_mask_trans_method('',) 
   #RETURNING 
   

   
END FUNCTION



#應用 a65 樣板自動產生(Version:4)
#+ 資料遮罩還原(FOR UPDATE)
PRIVATE FUNCTION arpi800_rpxb_t_mask_restore(ps_type)
   #add-point:mask_restore段define name="rpxb_t_mask_restore.define_customerization"
   {<point name="rpxb_t_mask_restore.define_customerization" edit="c" mark="Y"/>}
   #end add-point 
   DEFINE ps_type  LIKE type_t.chr50
   DEFINE li_idx   LIKE type_t.num10
   #add-point:mask_restore段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rpxb_t_mask_restore.define"
   {<point name="rpxb_t_mask_restore.define"/>}
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




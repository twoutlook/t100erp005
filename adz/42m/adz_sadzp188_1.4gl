#+ 程式版本......: T100 Version 1.00.00 Build-0001 at 14/12/10
#
#+ 程式代碼......: sadzp188_1
#+ 設計人員......: Janet
# Prog. Version..: 'T100-12.01.21(00000)'     #
#
# Program name   : sadzp188_1.4gl 
# Description    : 比對新/舊版報表元件設計資料的Patch工具
# Memo           :
#+ ...........: 151023 #151023-00006#1 調整語系
#+ ...........: 151023 #151029-00002#1 include adzi888_global.inc,調整每種模式抓的資料
#+ ...........: 151201 #151201-00001#1 調整sql
#+ ...........: 151215 #151215-00015#1 調整xg merge的規範，g_run_mode=2、4 patch及產中過單，是抓s，其餘抓s跟c
#+ ...........: 160331 #160330-00019#3 調整撈標準時，gzgf003多撈x
#+ ...........: 160602 #160602-00015#1 語系抓系統預設有的語系
#+ ...........: 161011 #161011-00042#1 調整當gzgf003=x時，回抓gzgf003=s的標準樣板

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
#151029-00002#1 add -(s)
&include "../4gl/adzi888_global.inc"                      
#151029-00002#1 add -(e)

DEFINE g_error_message       STRING                      #錯誤訊息


PUBLIC FUNCTION sadzp188_1(p_dzga001)
   DEFINE p_dzga001         LIKE dzga_t.dzga001         #報表元件代號
   DEFINE l_time_s          DATETIME YEAR TO SECOND     #FRACTION(4)
   DEFINE l_time_e          DATETIME YEAR TO SECOND     #FRACTION(4)
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_lang_cnt        LIKE type_t.num5            
   DEFINE l_gzgdl001        DYNAMIC ARRAY OF VARCHAR(6)       
   DEFINE l_cnt             LIKE type_t.num5            
   DEFINE l_current         LIKE gzgf_t.gzgfmoddt  
   DEFINE l_gzgg_s          DYNAMIC ARRAY OF RECORD LIKE gzgg_t.* #報表元件設計-樣板明細檔(XG)_default/default
   DEFINE l_gzgg            DYNAMIC ARRAY OF RECORD LIKE gzgg_t.* #報表元件設計-樣板明細檔(XG)  
   #DEFINE l_gzgf000         DYNAMIC ARRAY OF VARCHAR(80)          #報表樣板ID    #151029-00002#1  mark
   #151029-00002#1  add -(s)
   DEFINE l_gzgf            DYNAMIC ARRAY OF RECORD  
            gzgf000         LIKE gzgf_t.gzgf000,   #報表樣板ID   
            gzgf003         LIKE gzgf_t.gzgf003    #客製標示
            END RECORD    
   #151029-00002#1  add -(s)         
   DEFINE l_k               LIKE type_t.num5                  
   DEFINE l_gzde005         LIKE gzde_t.gzde005     
   DEFINE l_gzge003         LIKE gzge_t.gzge003 
   DEFINE l_max_gzgg004     LIKE gzgg_t.gzgg004
   DEFINE l_sql             STRING                                #151029-00002#1 add 
   DEFINE l_gzgf003         LIKE gzgf_t.gzgf003                   ##160330-00019#3 add

   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   SELECT gzde005 INTO l_gzde005 FROM gzde_t
    WHERE gzde001 = p_dzga001
   ##只做xg
   IF l_gzde005 <> 'X' THEN
      RETURN TRUE, "not xg rep"
   END IF

   
   LET l_time_s = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY "   Rep merge strat time : ", l_time_s, ASCII 10

   ##多語言
   DECLARE gzgdl000 SCROLL CURSOR FOR
    SELECT gzzy001 FROM gzzy_t                             #151023-00006#1 add
    #SELECT gzgdl001 FROM gzgdl_t WHERE gzgdl000='default' #151023-00006#1 mark
   LET l_lang_cnt = 1
   CALL l_gzgdl001.clear()
   FOREACH gzgdl000 INTO l_gzgdl001[l_lang_cnt]
     LET l_lang_cnt = l_lang_cnt + 1
   END FOREACH
   CALL l_gzgdl001.deleteElement(l_lang_cnt)

    ##先抓出同報表元件代號,非defualt、default所有gzgf000，代表是客戶從標準樣板修改而來的樣板
   LET l_k = 1
   CALL l_gzgf.clear()   #151029-00002#1 add
   #151029-00002#1 mark -(s)
   #CALL l_gzgf000.clear()
   #DECLARE adzp188_get_gzgf_data_cs CURSOR FOR       
    #SELECT gzgf000 FROM gzgf_t                         
     #WHERE gzgf001 = p_dzga001
       ##AND((gzgf004 <> 'default' AND gzgf005 <> 'default') OR gzgf004 <> 'default' OR gzgf005 <> 'default' )   #151023-00006#1 mark
       #AND((gzgf004 <> 'default' AND gzgf005 <> 'default') OR gzgf004 <> 'default' OR gzgf005 <> 'default' OR (gzgf004 = 'default' AND gzgf005 = 'default' AND gzgf002 <> p_dzga001) )    #151023-00006#1 add
       #AND gzgf003 = 's'  
   #151029-00002#1 mark -(e)
   #151029-00002#1 add -(s)
   LET l_sql = " SELECT gzgf000,gzgf003 FROM gzgf_t ",
               "  WHERE gzgf001 = '",p_dzga001,"'",
               "    AND ((gzgf004 <> 'default' AND gzgf005 <> 'default') OR gzgf004 <> 'default' OR gzgf005 <> 'default'",
               "     OR  (gzgf004 = 'default' AND gzgf005 = 'default' AND gzgf002 <> '",p_dzga001,"'))"  #151201-00001#1 add )
               #IF g_run_mode = "6" THEN                      #151215-00015#1 mark 
               IF g_run_mode = "2"  OR g_run_mode = "4" THEN  #151215-00015#1 add  只有產中過單、patch是撈標準資料
                  #LET l_sql = l_sql ,"    AND gzgf003 = 's' "                   ##160330-00019#3 mark
                  LET l_sql = l_sql ,"    AND (gzgf003 = 's' OR gzgf003 = 'x') " ##160330-00019#3 add
               ELSE
                  #LET l_sql = l_sql ,"    AND (gzgf003 = 's' OR gzgf003 = 'c') "                   ##160330-00019#3 mark
                  LET l_sql = l_sql ,"    AND (gzgf003 = 's' OR gzgf003 = 'x' OR gzgf003 = 'c') "   ##160330-00019#3 add
               END IF
   PREPARE adzp188_get_gzgf_data_pre FROM l_sql
   DECLARE adzp188_get_gzgf_data_cs CURSOR FOR adzp188_get_gzgf_data_pre               
   FOREACH adzp188_get_gzgf_data_cs INTO l_gzgf[l_k].*
      LET l_k = l_k + 1
   END FOREACH
   #CALL l_gzgf000.deleteElement(l_k)     #151029-00002#1 mark   
   CALL l_gzgf.deleteElement(l_k)         #151029-00002#1 add
 
    ##取出gzgf_t 使用者/角色=default,客製標示 = s
    DECLARE sadzp188_get_gzgg_data_cs CURSOR FOR           
    SELECT * FROM gzgg_t    
     #改成依不同模式抓標準或客製的default樣板
     #WHERE gzgg000 IN ( SELECT gzgf000 FROM gzgf_t WHERE gzgf001 = ? AND gzgf002 = ? AND gzgf003 ='s' AND gzgf004 = 'default' AND gzgf005 ='default')   #151029-00002#1 mark
     WHERE gzgg000 IN ( SELECT gzgf000 FROM gzgf_t WHERE gzgf001 = ? AND gzgf002 = ? AND gzgf003 = ? AND gzgf004 = 'default' AND gzgf005 ='default')    #151029-00002#1 add
       AND gzgg002 = ? 
     ORDER BY gzgg004 

   

    #FOR l_k = 1 TO l_gzgf000.getLength()     #151029-00002#1 mark 
    FOR l_k = 1 TO l_gzgf.getLength()         #151029-00002#1 add
      FOR l_lang_cnt = 1 TO l_gzgdl001.getLength()    
         ##抓出該語系使用者/角色=default,客製標示 = s 的gzgg_t
        #IF l_gzgdl001[l_lang_cnt] ="zh_TW" OR l_gzgdl001[l_lang_cnt] ="zh_CN" THEN   #151029-00002#1 add     #160602-00015    mark
         LET l_i = 1 
         CALL l_gzgg_s.clear()  

         #160330-00019#3 add -(s)
          IF l_gzgf[l_k].gzgf003 ='x' THEN 
             LET l_gzgf003 ='s'
          ELSE
             LET l_gzgf003 = l_gzgf[l_k].gzgf003
          END IF 
         #160330-00019#3 add -(e)
         
         #FOREACH sadzp188_get_gzgg_data_cs USING p_dzga001 ,p_dzga001,l_gzgf[l_k].gzgf003,l_gzgdl001[l_lang_cnt] INTO l_gzgg_s[l_i].*  #151029-00002#1 mark
         #FOREACH sadzp188_get_gzgg_data_cs USING p_dzga001 ,p_dzga001,l_gzgf[l_k].gzgf003,l_gzgdl001[l_lang_cnt] INTO l_gzgg_s[l_i].*   #151029-00002#1 add  增加客製標示 #160330-00019#3 mark
         FOREACH sadzp188_get_gzgg_data_cs USING p_dzga001 ,p_dzga001,l_gzgf003,l_gzgdl001[l_lang_cnt] INTO l_gzgg_s[l_i].*   #160330-00019#3 add  x的也是抓s
                LET l_i = l_i + 1
         END FOREACH
         CALL l_gzgg_s.deleteElement(l_i)
      
         FOR l_i = 1 TO l_gzgg_s.getLength()

              ##目前只存繁中與簡中
              #IF l_gzgdl001[l_lang_cnt] ="zh_TW" OR l_gzgdl001[l_lang_cnt] ="zh_CN" THEN   #151029-00002#1 mark
                  LET l_cnt = 0 
                  SELECT COUNT(gzgg001) INTO l_cnt FROM gzgg_t
                   #WHERE gzgg000 = l_gzgf000[l_k] AND gzgg002 = l_gzgdl001[l_lang_cnt]        #151029-00002#1 mark 
                   WHERE gzgg000 = l_gzgf[l_k].gzgf000 AND gzgg002 = l_gzgdl001[l_lang_cnt]    #151029-00002#1 add
                     AND gzgg001 = l_gzgg_s[l_i].gzgg001 
                    
 
                  IF l_cnt = 0 THEN    ##將dzgl028直接存入gzgg001

                     ##將後面的先重新變更順序 
                     #CALL sadzp188_1_reset_gzgg004(l_gzgf000[l_k],l_gzgdl001[l_lang_cnt],l_gzgg_s[l_i].gzgg004)
                     SELECT max(gzgg004)+1 INTO l_max_gzgg004
                       FROM gzgg_t
                      #WHERE gzgg000 = l_gzgf000[l_k] AND gzgg002 = l_gzgdl001[l_lang_cnt]   #151029-00002#1 mark 
                      WHERE gzgg000 = l_gzgf[l_k].gzgf000 AND gzgg002 = l_gzgdl001[l_lang_cnt]    #151029-00002#1 add
                     ##存入gzgg_t
                     ##MERGE的欄位不做顯示
                     LET l_gzgg_s[l_i].gzgg006 = 'N' 
                     INSERT INTO gzgg_t (gzgg000,gzgg001,gzgg002,gzgg003,gzgg004,gzgg005,gzgg006,gzgg007,gzgg008,
                                         gzgg009,gzgg010,gzgg011,gzgg012,gzgg013,gzgg014,gzgg015,gzgg016,gzgg017,
                                         gzgg018,gzgg019,gzgg020,gzgg021,gzgg022,gzgg023,gzgg024,gzgg025,gzgg026,
                                         gzgg027)

                            #VALUES(l_gzgf000[l_k],l_gzgg_s[l_i].gzgg001,l_gzgdl001[l_lang_cnt],l_gzgg_s[l_i].gzgg003,l_max_gzgg004,    #151029-00002#1 mark 
                            VALUES(l_gzgf[l_k].gzgf000,l_gzgg_s[l_i].gzgg001,l_gzgdl001[l_lang_cnt],l_gzgg_s[l_i].gzgg003,l_max_gzgg004,     #151029-00002#1 add
                                   l_gzgg_s[l_i].gzgg005,l_gzgg_s[l_i].gzgg006,l_gzgg_s[l_i].gzgg007,l_gzgg_s[l_i].gzgg008,
                                   l_gzgg_s[l_i].gzgg009,l_gzgg_s[l_i].gzgg010,l_gzgg_s[l_i].gzgg011,l_gzgg_s[l_i].gzgg012,
                                   l_gzgg_s[l_i].gzgg013,l_gzgg_s[l_i].gzgg014,l_gzgg_s[l_i].gzgg015,l_gzgg_s[l_i].gzgg016,
                                   l_gzgg_s[l_i].gzgg017,l_gzgg_s[l_i].gzgg018,l_gzgg_s[l_i].gzgg019,l_gzgg_s[l_i].gzgg020,
                                   l_gzgg_s[l_i].gzgg021,l_gzgg_s[l_i].gzgg022,l_gzgg_s[l_i].gzgg023,l_gzgg_s[l_i].gzgg024,
                                   l_gzgg_s[l_i].gzgg025,l_gzgg_s[l_i].gzgg026,l_gzgg_s[l_i].gzgg027)   

                     IF STATUS THEN
                        LET g_error_message = "merge insert gzgg:", l_gzgg_s[l_i].gzgg001 CLIPPED, ":",l_gzgdl001[l_lang_cnt],":", cl_getmsg(SQLCA.sqlcode, g_lang)
                        DISPLAY g_error_message
                     END IF                    

                     ##自定欄位存入欄位說明到gzge

                     LET l_gzge003 =''
                     SELECT gzge003 INTO l_gzge003 FROM gzge_t
                      WHERE gzge000 = l_gzgg_s[l_i].gzgg000 ##用default/default/客製s的gzgg000去找                                          
                       AND gzge001 = l_gzgg_s[l_i].gzgg001 AND gzge002 = l_gzgdl001[l_lang_cnt]  
                     IF NOT cl_null(l_gzge003) THEN  
                         LET l_cnt =0                                        
                         SELECT COUNT(gzge003) INTO l_cnt FROM gzge_t
                          #WHERE gzge000 = l_gzgf000[l_k]       #151029-00002#1 mark 
                          WHERE gzge000 = l_gzgf[l_k].gzgf000   #151029-00002#1 add                              
                            AND gzge001 = l_gzgg_s[l_i].gzgg001 AND gzge002 = l_gzgdl001[l_lang_cnt]  
                         IF l_cnt = 0 THEN    
                             LET l_current = cl_get_current()                   
                             INSERT INTO gzge_t (gzgestus,gzge000,gzge001,gzge002,gzge003,gzgeownid, 
                                                              gzgeowndp,gzgecrtid,gzgecrtdp,gzgecrtdt)                                    
                                    #VALUES ('Y',l_gzgf000[l_k],l_gzgg_s[l_i].gzgg001,     #151029-00002#1 mark 
                                    VALUES ('Y',l_gzgf[l_k].gzgf000,l_gzgg_s[l_i].gzgg001, #151029-00002#1 add 
                                            l_gzgdl001[l_lang_cnt] ,l_gzge003,g_user,g_dept,g_user,g_dept,l_current)
                             IF SQLCA.sqlcode THEN
                                LET g_error_message = "merge insert gzge:", l_gzgg_s[l_i].gzgg001  CLIPPED, ":",l_gzgdl001[l_lang_cnt],":", cl_getmsg(SQLCA.sqlcode, g_lang)
                                DISPLAY g_error_message                                
                             END IF
                        END IF 
                     END IF 

                  #ELSE  ##若有存在 那要更新gzgg_t 的gzgg004 欄位順序
                       #UPDATE gzgg_t
                          #SET gzgg004 = l_gzgg_s[l_i].gzgg004
                        #WHERE gzgg000 = l_gzgf000[l_k] AND gzgg002 = l_gzgdl001[l_lang_cnt]
                          #AND gzgg001 = l_gzgg_s[l_i].gzgg001   
                  END IF 
              #END IF  #l_gzgdl001[l_lang_cnt] ="zh_TW" OR l_gzgdl001[l_lang_cnt] ="zh_CN"  #151029-00002#1 mark
         END FOR  #l_gzgg 
        #END IF  #l_gzgdl001[l_lang_cnt] ="zh_TW" OR l_gzgdl001[l_lang_cnt] ="zh_CN"         #151029-00002#1 add  #160602-00015# mark
      END FOR   
    END FOR     

    ##反向回去，用參考標準s做出的樣板 gzgg_t去查原標準s/default/default的gzgg_t，若參考的gzgg_t有而標準的gzgg_t沒有，則參考的gzgg_t要刪掉資料
    LET l_i = 1 
    CALL l_gzgg.clear()
    ##抓出用參考標準s做出的樣板gzgg_t 
    DECLARE adzp188_get_gzgg_data SCROLL CURSOR FOR
     SELECT * FROM gzgg_t 
      WHERE gzgg000 = ? AND gzgg002 = ?            
      ORDER BY gzgg004 

   #FOR l_k = 1 TO l_gzgf000.getLength()   #151029-00002#1 mark
   FOR l_k = 1 TO l_gzgf.getLength()   #151029-00002#1 add
       FOR l_lang_cnt = 1 TO l_gzgdl001.getLength()
           ##抓出用參考標準s做出的樣板gzgg_t 資料
           LET l_i = 1
           #FOREACH adzp188_get_gzgg_data USING l_gzgf000[l_k],l_gzgdl001[l_lang_cnt] INTO l_gzgg[l_i].*   #151029-00002#1 mark
           FOREACH adzp188_get_gzgg_data USING l_gzgf[l_k].gzgf000,l_gzgdl001[l_lang_cnt] INTO l_gzgg[l_i].*    #151029-00002#1 add
             LET l_i = l_i + 1
           END FOREACH
           CALL l_gzgg.deleteElement(l_i)
            
           FOR l_i = 1 TO l_gzgg.getLength() 
                ##找標準s/default/default的gzgg_t
                #161011-00042#1 add -(s)
                IF l_gzgf[l_k].gzgf003 ='x' THEN
                   LET l_gzgf[l_k].gzgf003 ='s'
                END IF 
                #161011-00042#1 add -(e)
                LET l_cnt = 0                
                SELECT COUNT(gzgg001) INTO l_cnt FROM gzgg_t                       
                 #WHERE gzgg000 IN ( SELECT gzgf000 FROM gzgf_t WHERE gzgf001 = p_dzga001 AND gzgf002 = p_dzga001 AND gzgf003 ='s' AND gzgf004 ='default' AND gzgf005='default')  #151029-00002#1 mark
                 WHERE gzgg000 IN ( SELECT gzgf000 FROM gzgf_t WHERE gzgf001 = p_dzga001 AND gzgf002 = p_dzga001 AND gzgf003 = l_gzgf[l_k].gzgf003 AND gzgf004 ='default' AND gzgf005='default')   #151029-00002#1 add
                   AND gzgg002 = l_gzgdl001[l_lang_cnt]
                   AND gzgg001 = l_gzgg[l_i].gzgg001   #用組合後的欄位名去找
                   
                IF l_cnt = 0 THEN  #若反找default/default/標準=s 沒有，代表default/default/標準=s這筆的gzgg刪了 所以gzgg_t也要跟著刪
                     DELETE FROM gzgg_t 
                      #WHERE gzgg000 = l_gzgf000[l_k]     #報表樣板ID   #151029-00002#1 mark
                      WHERE gzgg000 = l_gzgf[l_k].gzgf000     #報表樣板ID    #151029-00002#1 add
                        AND gzgg002 = l_gzgdl001[l_lang_cnt]
                        AND gzgg001 = l_gzgg[l_i].gzgg001 
                      IF STATUS THEN
                         LET g_error_message = "merge delete gzgg_t:", l_gzgg[l_i].gzgg001  CLIPPED, ":",l_gzgdl001[l_lang_cnt],":", cl_getmsg(SQLCA.sqlcode, g_lang)
                         DISPLAY g_error_message                           
                      END IF 
                     ##刪除多語言 
                     DELETE FROM gzge_t 
                      #WHERE gzge000 = l_gzgf000[l_k]          #報表樣板ID  #151029-00002#1 mark
                      WHERE gzge000 =  l_gzgf[l_k].gzgf000     #報表樣板ID  #151029-00002#1 add
                        AND gzge002 = l_gzgdl001[l_lang_cnt]
                        AND gzge001 = l_gzgg[l_i].gzgg001 
                      IF STATUS THEN
                         LET g_error_message = "merge delete gzge_t:", l_gzgg[l_i].gzgg001  CLIPPED, ":",l_gzgdl001[l_lang_cnt],":", cl_getmsg(SQLCA.sqlcode, g_lang)
                         DISPLAY g_error_message                              
                      END IF 
                END IF       

          END FOR  #l_gzgg
        END FOR #l_gzgdl001
    END FOR #l_gzgf000
   
   LET l_time_e = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Rep merge cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE, ""
END FUNCTION



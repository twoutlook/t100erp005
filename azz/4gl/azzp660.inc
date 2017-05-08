SCHEMA ds

GLOBALS
   DEFINE g_gzal           RECORD
                              gzal001     LIKE gzal_t.gzal001, 
                              gzal001_desc LIKE type_t.chr1000,
                              gzal002     LIKE gzal_t.gzal002,
                              gzal003     LIKE gzal_t.gzal003,
                              gzal004     LIKE gzal_t.gzal004,
                              gzal004_desc LIKE type_t.chr1000,
                              gzal005     LIKE gzal_t.gzal005,
                              gzal006     LIKE gzal_t.gzal006
                           END RECORD
   DEFINE g_dzeb           DYNAMIC ARRAY OF RECORD
                              pk            LIKE type_t.chr1000,
                              fk            LIKE type_t.chr1000,
                              dzeb002       LIKE dzeb_t.dzeb002,
                              dzeb002_desc  LIKE type_t.chr1000
                           END RECORD
    TYPE type_rd           RECORD
                              pk            LIKE type_t.chr1000,
                              gzan004       LIKE gzan_t.gzan004,
                              gzan004_desc  LIKE type_t.chr1000,
                              gzan007        LIKE gzan_t.gzan007
                           END RECORD

   #      第 x 個單身   第x筆資料 欄位     資料
   #範例：g_rd_array[1].rd[1].dzeb002 = 'imaa001'
   DEFINE g_rd_array       ARRAY[10] OF RECORD
                             rd      DYNAMIC ARRAY OF type_rd
                           END RECORD 
   DEFINE g_fieldsel_idx   LIKE type_t.num5

   DEFINE g_now_rd_num     LIKE type_t.num5     #目前畫面上的右方單身是第幾個

   DEFINE g_table_tree     DYNAMIC ARRAY OF RECORD
                              tableid       LIKE dzea_t.dzea001,     #節點名稱：資料表代號
                              pid           LIKE type_t.chr100,      #父節點id
                              id            LIKE type_t.chr100,      #節點id
                              hasc          BOOLEAN,                 #是否有子節點 0:否 1:是
                              exp           BOOLEAN,                 #是否展開 0:不展開 1:展開
                              level         LIKE type_t.num5,        #階層
                              tablename     LIKE dzeal_t.dzeal003,   #資料表名稱 
                              table_type      LIKE dzea_t.dzea004      #檔案類型 
                           END RECORD
   DEFINE g_table_tree_idx LIKE type_t.num10 
END GLOBALS

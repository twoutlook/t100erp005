/* 
================================================================================
檔案代號:glcg_t
檔案名稱:自由核算項和摘要彈性取值的表結構設定
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glcg_t
(
glcgent       number(5)      ,/* 企業代碼 */
glcg001       varchar2(20)      ,/* 程式編號 */
glcg002       number(10,0)      ,/* 項次 */
glcg003       varchar2(80)      ,/* 備註說明 */
glcg004       varchar2(500)      ,/* 表名稱(多表逗號隔開) */
glcg005       varchar2(500)      ,/* 表之間欄位關聯條件 */
glcg006       varchar2(255)      ,/* 語言別(多欄位逗號隔開) */
glcg007       varchar2(10)      ,/* 參數欄位-企業編號(僅單欄位) */
glcg008       varchar2(10)      ,/* 參數欄位-帳套(僅單欄位) */
glcg009       varchar2(10)      ,/* 參數欄位-單據編號(僅單欄位) */
glcg010       varchar2(10)      ,/* 參數欄位-項次1(僅單欄位) */
glcg011       varchar2(10)      ,/* 參數欄位-項次2(僅單欄位) */
glcgstus       varchar2(10)      ,/* 狀態碼 */
glcgownid       varchar2(20)      ,/* 資料所有者 */
glcgowndp       varchar2(10)      ,/* 資料所屬部門 */
glcgcrtid       varchar2(20)      ,/* 資料建立者 */
glcgcrtdp       varchar2(10)      ,/* 資料建立部門 */
glcgcrtdt       timestamp(0)      ,/* 資料創建日 */
glcgmodid       varchar2(20)      ,/* 資料修改者 */
glcgmoddt       timestamp(0)      ,/* 最近修改日 */
glcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glcgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glcg012       varchar2(10)      /* 返回欄位 */
);
alter table glcg_t add constraint glcg_pk primary key (glcgent,glcg001,glcg002) enable validate;

create unique index glcg_pk on glcg_t (glcgent,glcg001,glcg002);

grant select on glcg_t to tiptop;
grant update on glcg_t to tiptop;
grant delete on glcg_t to tiptop;
grant insert on glcg_t to tiptop;

exit;
